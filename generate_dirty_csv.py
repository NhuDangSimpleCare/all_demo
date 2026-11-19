import csv
import random
import string
import os

random.seed(42)

NUM_ROWS = 5000

# --- Helpers ---
def rand_spaces():
    return " " * random.randint(0, 3)

def maybe_none(value, pct=0.07):
    """Return None (missing) ~pct of the time."""
    return None if random.random() < pct else value

# --- Data pools ---
first_names = [
    "Nguyễn Văn", "Trần Thị", "Lê Hoàng", "Phạm Minh", "Hoàng Thị",
    "Vũ Đức", "Đặng Thị", "Bùi Quang", "Đỗ Thị", "Ngô Thanh",
    "Dương Văn", "Lý Thị", "Hồ Minh", "Phan Thị", "Đinh Văn",
    "Tô Thị", "Mai Văn", "Trịnh Thị", "Cao Văn", "Lương Thị",
    "John", "Jane", "Michael", "Sarah", "David",
    "Emily", "Robert", "Lisa", "William", "Anna",
]
last_parts = [
    "An", "Bình", "Cường", "Dũng", "Em", "Phúc", "Giang", "Hà",
    "Khoa", "Linh", "Minh", "Nam", "Oanh", "Phong", "Quân",
    "Sơn", "Tú", "Uyên", "Vinh", "Xuân", "Yến", "Hùng",
    "Thảo", "Hương", "Lan", "Mai", "Ngọc", "Trang", "Hạnh", "Đào",
    "Smith", "Johnson", "Lee", "Brown", "Garcia",
]

cities = [
    "Hà Nội", "TP. Hồ Chí Minh", "Đà Nẵng", "Hải Phòng", "Cần Thơ",
    "Huế", "Nha Trang", "Vũng Tàu", "Biên Hòa", "Buôn Ma Thuột",
    "hà nội", "tp hcm", "HCM", "TPHCM", "tp. hồ chí minh",
    "da nang", "DA NANG", "hai phong", "Hải phòng", "can tho",
    "  Hà Nội ", "Đà Nẵng  ", " Nha Trang",
    "N/A", "", "null", "không rõ", "???",
]

products = [
    "Laptop Dell XPS 15", "iPhone 14 Pro Max", "Samsung Galaxy S23",
    "Tai nghe Sony WH-1000XM5", "Bàn phím cơ Keychron K2",
    "Chuột Logitech MX Master 3", "Màn hình LG 27inch 4K",
    "iPad Air M1", "MacBook Pro 14", "Xiaomi Redmi Note 12",
    "laptop dell xps 15", "IPHONE 14 PRO MAX", "samsung galaxy s23",
    "Tai Nghe Sony wh-1000xm5", "bàn phím cơ KEYCHRON K2",
    "Lap top Dell XPS 15", "Iphone 14 pro max", "Sam sung Galaxy S23",
    "Áo thun nam", "Giày thể thao Nike", "Nồi cơm điện Panasonic",
    "Tủ lạnh Sharp 300L", "Máy giặt LG 9kg", "Quạt điện Senko",
    "Dầu gội Head & Shoulders", "Sữa tắm Dove 500ml",
    "   iPhone 14 Pro Max  ", "laptop dell  xps  15",
]

statuses = [
    "Đã giao", "Đang xử lý", "Chờ thanh toán", "Đã hủy", "Hoàn trả",
    "da giao", "ĐANG XỬ LÝ", "cho thanh toan", "đã huỷ", "hoan tra",
    "Delivered", "Processing", "Pending", "Cancelled", "Returned",
    "pending", "DELIVERED", "",
    "N/A", "null", "unknown", "???", "  Đã giao  ",
]

payment_methods = [
    "COD", "Thẻ tín dụng", "Chuyển khoản", "Ví MoMo", "ZaloPay",
    "cod", "THẺ TÍN DỤNG", "chuyen khoan", "vi momo", "ZALOPAY",
    "Credit Card", "Bank Transfer", "Cash", "E-wallet",
    "", "N/A", "null", "khác",
]

email_domains = [
    "gmail.com", "yahoo.com", "hotmail.com", "outlook.com",
    "email.com", "company.vn", "fpt.vn", "vnn.vn",
]

phone_formats = [
    "09{}{}{}{}{}{}{}", "03{}{}{}{}{}{}{}", "07{}{}{}{}{}{}{}",
    "08{}{}{}{}{}{}{}", "05{}{}{}{}{}{}{}",
    "+84 9{}{} {}{}{} {}{}{}", "+84-3{}{}-{}{}{}-{}{}{}",
    "0{}{}{}.{}{}{}.{}{}{}{}", "(84) 9{}{}{}{}{}{}{}", 
    "09{}{}{}{}{}{}{} ", "  03{}{}{}{}{}{}{}",
    "abcdefgh", "123", "N/A", "", "0000000000",
]

date_formats = [
    "{:02d}/{:02d}/{:04d}",      # DD/MM/YYYY
    "{:04d}-{:02d}-{:02d}",      # YYYY-MM-DD (params reordered below)
    "{:02d}-{:02d}-{:04d}",      # DD-MM-YYYY
    "{:02d}.{:02d}.{:04d}",      # DD.MM.YYYY
    "{:04d}/{:02d}/{:02d}",      # YYYY/MM/DD (params reordered below)
    "{:02d} thg {:02d}, {:04d}", # DD thg MM, YYYY
]

ratings = [1, 2, 3, 4, 5, 0, -1, 6, 10, None, "N/A", "five", "4.5", "3,5", "", "★★★★"]

feedback_texts = [
    "Sản phẩm tốt, giao hàng nhanh",
    "Hàng bị lỗi, yêu cầu đổi trả",
    "OK",
    "Tạm được",
    "Rất hài lòng!!!",
    "Giao hàng chậm, đóng gói cẩu thả",
    "Chất lượng không như mô tả",
    "5 sao, sẽ mua lại",
    "   ",
    "",
    "N/A",
    "null",
    "???",
    "Great product, fast delivery!",
    "Not satisfied at all",
    "👍👍👍",
    "Hàng fake 100%!!! Lừa đảo!!!",
    "Giao sai màu, sai size nhưng lười đổi",
    "Đóng gói cẩn thận, hàng đẹp. Sẽ ủng hộ shop dài dài ạ <3",
    "Mua lần 2 rồi. Shop uy tín.",
    None,
]


def gen_phone():
    fmt = random.choice(phone_formats)
    try:
        digits = [str(random.randint(0,9)) for _ in range(10)]
        return fmt.format(*digits)
    except (IndexError, KeyError):
        return fmt  # return as-is for non-format strings

def gen_email(name_str):
    if random.random() < 0.08:
        return random.choice(["", "N/A", "null", "invalid-email", "abc@", "@gmail.com", "test@@test.com", "   "])
    base = name_str.lower().replace(" ", ".").replace("ă","a").replace("â","a").replace("đ","d").replace("ê","e").replace("ô","o").replace("ơ","o").replace("ư","u").replace("ị","i").replace("ệ","e").replace("ọ","o").replace("ủ","u").replace("ế","e").replace("ồ","o").replace("ừ","u").replace("ớ","o").replace("ạ","a").replace("ả","a").replace("ẫ","a").replace("ầ","a").replace("ấ","a").replace("ắ","a").replace("ằ","a").replace("ẳ","a").replace("ẵ","a").replace("ặ","a").replace("ã","a").replace("á","a").replace("à","a")
    base = "".join(c for c in base if c.isalnum() or c == ".")
    domain = random.choice(email_domains)
    num = random.randint(1, 999)
    return f"{base}{num}@{domain}"

def gen_date(year_range=(2020, 2026)):
    y = random.randint(*year_range)
    m = random.randint(1, 12)
    d = random.randint(1, 28)
    
    if random.random() < 0.05:
        return random.choice(["", "N/A", "null", "??/??/????", "2023-13-45", "31/02/2024", "00/00/0000", "ngày mai"])
    
    fmt_choice = random.randint(0, len(date_formats) - 1)
    fmt = date_formats[fmt_choice]
    
    if fmt_choice in [1]:  # YYYY-MM-DD
        return fmt.format(y, m, d)
    elif fmt_choice in [4]:  # YYYY/MM/DD
        return fmt.format(y, m, d)
    else:  # DD/MM/YYYY variants
        return fmt.format(d, m, y)

def gen_price():
    if random.random() < 0.05:
        return random.choice(["", "N/A", "null", "miễn phí", "0", "-500000", "999999999999", "abc"])
    
    base = random.choice([
        random.randint(50, 500) * 1000,          # 50k - 500k
        random.randint(500, 5000) * 1000,         # 500k - 5M
        random.randint(5000, 50000) * 1000,       # 5M - 50M
        random.randint(10, 200) * 100,            # 1k - 20k (small items)
    ])
    
    # Various number formats
    fmt_choice = random.randint(0, 5)
    if fmt_choice == 0:
        return str(base)
    elif fmt_choice == 1:
        return f"{base:,}"  # 1,000,000
    elif fmt_choice == 2:
        return f"{base:,.0f}".replace(",", ".")  # 1.000.000
    elif fmt_choice == 3:
        return f"{base} VND"
    elif fmt_choice == 4:
        return f"{base}đ"
    else:
        return f"  {base}  "

def gen_quantity():
    if random.random() < 0.04:
        return random.choice(["", "N/A", "0", "-3", "1000000", "abc", "null"])
    return str(random.randint(1, 20))

def gen_address():
    if random.random() < 0.06:
        return random.choice(["", "N/A", "null", "???", "   ", "không có"])
    
    so = random.randint(1, 500)
    duong = random.choice([
        "Nguyễn Huệ", "Lê Lợi", "Trần Hưng Đạo", "Hai Bà Trưng",
        "Điện Biên Phủ", "Lý Thường Kiệt", "Phan Đình Phùng",
        "Hoàng Diệu", "Nguyễn Trãi", "Lê Duẩn", "Võ Văn Tần",
        "Pasteur", "Cách Mạng Tháng 8", "Nguyễn Văn Cừ",
    ])
    quan = random.choice([
        "Quận 1", "Quận 3", "Quận 7", "Quận Bình Thạnh", "Quận Gò Vấp",
        "Ba Đình", "Hoàn Kiếm", "Đống Đa", "Thanh Xuân", "Cầu Giấy",
        "Hải Châu", "Sơn Trà", "Ngũ Hành Sơn",
        "q.1", "Q1", "q7", "binh thanh", "GO VAP",
    ])
    city = random.choice(cities[:10])
    
    sep = random.choice([", ", " - ", "/ ", ",", " , "])
    
    parts = [f"{so} {duong}", quan, city]
    if random.random() < 0.15:
        parts = parts[:2]  # missing city
    if random.random() < 0.1:
        parts = [parts[0]]  # only street
    
    return sep.join(parts)

def gen_id(i):
    """Generate order ID with inconsistent formats."""
    formats = [
        f"ORD-{i:06d}",
        f"ORD{i:06d}",
        f"ord-{i:06d}",
        f"#{i}",
        f"DH{i:05d}",
        f"DH-{i}",
        f"{i}",
        f"  ORD-{i:06d}  ",
    ]
    return random.choice(formats)


# --- Generate CSV ---
output_path = os.path.join(r"c:\Users\cong chua sofia\Downloads\AII_DEMO", "sample_dirty_data.csv")

with open(output_path, "w", newline="", encoding="utf-8-sig") as f:
    writer = csv.writer(f)
    
    # Header
    writer.writerow([
        "order_id", "customer_name", "email", "phone", "address", "city",
        "product", "quantity", "unit_price", "total_price",
        "order_date", "delivery_date", "status", "payment_method",
        "rating", "feedback", "coupon_code", "is_member"
    ])
    
    seen_ids = set()
    row_num = 0
    
    while row_num < NUM_ROWS:
        i = row_num + 1
        
        # ~3% exact duplicate rows
        if row_num > 100 and random.random() < 0.03:
            dup_idx = random.randint(0, row_num - 1)
            # We can't easily duplicate, so we'll create near-duplicates
        
        order_id = gen_id(i)
        
        # ~2% duplicate order IDs
        if random.random() < 0.02 and seen_ids:
            order_id = random.choice(list(seen_ids))
        seen_ids.add(order_id.strip())
        
        name = f"{random.choice(first_names)} {random.choice(last_parts)}"
        # Random casing issues
        if random.random() < 0.1:
            name = name.upper()
        elif random.random() < 0.1:
            name = name.lower()
        elif random.random() < 0.05:
            name = rand_spaces() + name + rand_spaces()
        
        email = gen_email(name)
        phone = gen_phone()
        address = gen_address()
        city = maybe_none(random.choice(cities))
        product = maybe_none(random.choice(products))
        quantity = gen_quantity()
        unit_price = gen_price()
        
        # Total = qty * price but sometimes wrong
        try:
            q = int(quantity)
            p_str = str(unit_price).replace(",", "").replace(".", "").replace(" VND", "").replace("đ", "").replace(" ", "")
            p = int(p_str)
            total = q * p
            if random.random() < 0.08:
                total = total + random.randint(-100000, 100000)  # intentionally wrong
            total_price = str(total)
        except (ValueError, TypeError):
            total_price = random.choice(["", "N/A", "error", "null"])
        
        order_date = gen_date((2020, 2026))
        delivery_date = gen_date((2020, 2026))
        
        status = maybe_none(random.choice(statuses))
        payment = maybe_none(random.choice(payment_methods))
        rating = random.choice(ratings)
        feedback = random.choice(feedback_texts)
        
        # Coupon codes - messy
        if random.random() < 0.7:
            coupon = ""
        else:
            coupon = random.choice([
                "SALE10", "sale10", "GIAM20", "giam20", "FREESHIP",
                "freeship", "VIP50", "NEWUSER", "newuser",
                "SALE 10", " GIAM20 ", "N/A", "null", "expired",
                "BLACKFRIDAY2024", "TET2025", "11.11", "12.12",
            ])
        
        # is_member field - inconsistent boolean
        is_member = random.choice([
            "Yes", "No", "yes", "no", "YES", "NO",
            "1", "0", "True", "False", "true", "false",
            "TRUE", "FALSE", "Y", "N", "y", "n",
            "Có", "Không", "có", "không",
            "", "N/A", "null", "???",
        ])
        
        row = [
            order_id, name, email, phone, address, city,
            product, quantity, unit_price, total_price,
            order_date, delivery_date, status, payment,
            rating, feedback, coupon, is_member
        ]
        
        # Replace None with random empty representations
        row = [
            random.choice(["", "N/A", "null", "None", "  "]) if v is None else v
            for v in row
        ]
        
        writer.writerow(row)
        row_num += 1

print(f"✅ Generated {NUM_ROWS} rows -> {output_path}")
