# תמונת בסיס קלה ויעילה
FROM python:3.11-alpine

# יצירת תיקיית עבודה
WORKDIR /app

# העתקה והתקנה של התלויות
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# העתקת קוד המקור
COPY app.py .

# אבטחה: ריצה עם משתמש שאינו root
RUN adduser -D appuser
USER appuser

# חשיפת הפורט שבו האפליקציה מאזינה
EXPOSE 5000

# פקודת ההרצה
CMD ["python", "app.py"]