from fastapi import FastAPI, HTTPException, Form
from pydantic import BaseModel, EmailStr
from fastapi.middleware.cors import CORSMiddleware
import random
import string
import smtplib
from email.mime.text import MIMEText
from datetime import datetime, timedelta
import pymysql
import hashlib
import os
from dotenv import load_dotenv
from typing import Optional
from flask import Flask, request, jsonify
import bcrypt
from passlib.context import CryptContext


app = Flask(__name__)


# Load environment variables
load_dotenv()

app = FastAPI()

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"]
)

# Database connection
def get_db_connection():
    return pymysql.connect(
        host=os.getenv("DB_HOST", "localhost"),
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", "musyaml1357S"),
        database=os.getenv("DB_NAME", "authsleepy"),
        charset='utf8mb4'
    )

# Models
class User(BaseModel):
    email: EmailStr
    password: str
    name: str
    gender: str
    birth_date: str  # Format: "YYYY-MM-DD"
    height: float    # Tinggi badan dalam cm
    weight: float    # Berat badan dalam kg

class RegisterRequest(BaseModel):
    email: EmailStr
    password: str

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class EmailRequest(BaseModel):
    email: EmailStr

class OTPVerification(BaseModel):
    email: EmailStr
    otp_code: str

class PasswordReset(BaseModel):
    email: EmailStr
    new_password: str
    otp_code: str

class UserDataRequest(BaseModel):
    email: EmailStr
    password: str

def send_email(recipient: str, otp: str):
    sender = os.getenv("EMAIL_USER")
    password = os.getenv("EMAIL_PASSWORD")
    
    if not sender or not password:
        raise HTTPException(status_code=500, detail="Email configuration not set")
    
    subject = "Reset Password OTP"
    body = f"Your OTP for resetting your password is: {otp}"
    
    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = sender
    msg["To"] = recipient

    try:
        with smtplib.SMTP("smtp.gmail.com", 587) as server:
            server.starttls()
            server.login(sender, password)
            server.sendmail(sender, recipient, msg.as_string())
    except Exception as e:
        print(f"Failed to send email: {str(e)}")
        raise HTTPException(status_code=500, detail="Failed to send OTP email")
    
def reset_password(new_password):
    # Ensure the password is encoded to bytes
    password_bytes = new_password.encode('utf-8')
    
    # Generate a new salt and hash the password
    hashed_password = bcrypt.hashpw(password_bytes, bcrypt.gensalt())
    
    # Store hashed_password in the database
    return hashed_password.decode('utf-8')  # Store as string

@app.post("/register/")
async def register_user(register_data: RegisterRequest):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Hash the password before storing it
        hashed_password = bcrypt.hashpw(register_data.password.encode('utf-8'), bcrypt.gensalt())

        # Store the email and hashed password in the database
        cursor.execute(
            """INSERT INTO users (email, password) VALUES (%s, %s)""",
            (register_data.email, hashed_password)
        )
        conn.commit()

        return {"message": "User  registered successfully"}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()

# Gunakan PassLib untuk konsistensi
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

@app.post("/login/")
async def login_user(login_data: LoginRequest):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute(
            """SELECT email, password FROM users 
               WHERE email = %s""",
            (login_data.email,)
        )
        user = cursor.fetchone()
        
        if not user:
            raise HTTPException(
                status_code=401,
                detail="Invalid email or password"
            )
        
        stored_hashed_password = user[1]  # Stored hashed password

        # Verifikasi password dengan hash yang disimpan menggunakan bcrypt
        if not pwd_context.verify(login_data.password, stored_hashed_password):
            raise HTTPException(
                status_code=401,
                detail="Invalid email or password"
            )
        
        return {
            "message": "Login successful",
            "email": user[0]
        }

    except HTTPException as he:
        raise he
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@app.post("/request-otp/")
async def request_otp(email_request: EmailRequest):
    conn = get_db_connection()
    cursor = conn.cursor(pymysql.cursors.DictCursor)

    try:
        # Check if email exists
        cursor.execute(
            """SELECT email 
               FROM users 
               WHERE email = %s""",
            (email_request.email,)
        )
        user = cursor.fetchone()

        if not user:
            raise HTTPException(
                status_code=404,
                detail=f"Email {email_request.email} not found in database"
            )

        # Generate OTP
        otp = ''.join(random.choices(string.digits, k=6))
        expires_at = datetime.now() + timedelta(minutes=10)

        # Update OTP in database
        cursor.execute(
            """UPDATE users 
               SET otp_code = %s, 
                   otp_expires_at = %s, 
                   otp_is_used = FALSE 
               WHERE email = %s""",
            (otp, expires_at, email_request.email)
        )
        rows_affected = cursor.rowcount
        conn.commit()

        if rows_affected == 0:
            raise HTTPException(
                status_code=500,
                detail="Failed to update OTP in database"
            )

        # Attempt to send email
        try:
            send_email(email_request.email, otp)
        except Exception as e:
            print(f"Failed to send email: {str(e)}")  # Log email error for debugging

        # Always return a success message regardless of email status
        return {
            "message": "OTP sent successfully",
            "email": email_request.email,
            "expires_in": "10 minutes"
        }

    except HTTPException as he:
        raise he
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Unexpected error: {str(e)}"
        )
    finally:
        cursor.close()
        conn.close()



@app.post("/verify-otp/")
async def verify_otp(verification: OTPVerification):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Check OTP validity
        cursor.execute(
            """SELECT otp_expires_at, otp_is_used 
               FROM users 
               WHERE email = %s AND otp_code = %s""",
            (verification.email, verification.otp_code)
        )
        result = cursor.fetchone()
        
        if not result:
            raise HTTPException(status_code=400, detail="Invalid OTP")
            
        expires_at, is_used = result
        
        if is_used:
            raise HTTPException(status_code=400, detail="OTP already used")
            
        if datetime.now() > expires_at:
            raise HTTPException(status_code=400, detail="OTP expired")

        # Mark OTP as used
        cursor.execute(
            "UPDATE users SET otp_is_used = TRUE WHERE email = %s",
            (verification.email,)
        )
        conn.commit()
        
        return {"message": "OTP verified successfully"}

    except HTTPException as he:
        raise he
    except Exception as e:
        conn.rollback()
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@app.post("/reset-password/")
async def reset_password(reset_data: PasswordReset):
    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Hash password baru menggunakan bcrypt
        hashed_password = pwd_context.hash(reset_data.new_password)
        
        cursor.execute(
            """UPDATE users SET password = %s WHERE email = %s""",
            (hashed_password, reset_data.email)
        )
        conn.commit()

        return {"message": "Password successfully reset"}

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        cursor.close()
        conn.close()


        