# Gintonic Commission — ดีพลอย Vercel + Supabase

## 1) Supabase
1. สร้างโปรเจกต์ → SQL Editor → วาง/รัน `supabase.sql`
2. Authentication → Users → **Add user** (อีเมล+รหัสผ่านของคุณ, ติ๊ก Auto Confirm)
3. Authentication → Sign In / Providers → **ปิด "Allow new users to sign up"**
4. รันบรรทัดสุดท้ายใน `supabase.sql` (ปลดคอมเมนต์ แก้อีเมล) เพื่อให้บัญชีนี้เป็นแอดมิน
5. Project Settings → API → คัดลอก Project URL และ anon/publishable key ใส่ใน `config.js`

## 2) Vercel
- ลากโฟลเดอร์นี้ขึ้น Vercel หรือ push ขึ้น GitHub แล้ว Import (Framework: Other, ไม่มี build command, output = root)

## 3) ใช้งาน
- เข้าแอดมินที่ `https://โดเมนของคุณ/#/admin` → ล็อกอิน → แก้ไข → "บันทึกร่าง" (เก็บในเบราว์เซอร์) → "เผยแพร่การเปลี่ยนแปลง" (บันทึกลง Supabase ผู้เข้าชมเห็นทันที)
- ปุ่ม "จัดการเว็บไซต์" จะขึ้นเฉพาะตอนที่คุณล็อกอินแล้ว

## ข้อควรรู้
- รูปทั้งหมดถูกเก็บเป็น data URI ในแถวเดียวของตาราง (ย่อรูปอัตโนมัติแล้ว) ถ้ารูปเยอะมากควรย้ายไป Supabase Storage
- **ข้อมูลทั้งหมดใน `site_content` อ่านได้โดยสาธารณะ** รวมช่อง "หมายเหตุภายใน", ชื่อลูกค้า, บัญชี, ช่องทางรับงานของคิว แม้ปิดไม่ให้แสดงบนหน้าเว็บ ใครเปิด DevTools ก็เห็น (เหมือนเวอร์ชันเดิมที่ฝังข้อมูลไว้ในไฟล์) จึงอย่าใส่ข้อมูลที่ไม่ต้องการให้ใครเห็นไว้ในช่องเหล่านั้น หรือให้แยกเก็บเป็นตาราง private
