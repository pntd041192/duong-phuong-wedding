# Wedding Invitation — Dương & Phương

Bộ website thiệp cưới riêng gồm:
- `index.html`: website công khai, màn hình mở thiệp, Hero gõ chữ, album ảnh đổi thumbnail, lịch cưới + countdown, gia đình, mini quiz.
- `admin.html`: Admin đăng nhập, chỉnh sửa nội dung, upload ảnh, chỉnh vị trí chữ Hero, màu sắc/font, xem Preview, lưu nháp và xuất bản.
- `config.js`: nơi khai báo Supabase URL và anon/public key.
- `supabase-schema.sql`: tạo bảng, RLS và Storage bucket.
- `assets/`: thư mục dự kiến cho ảnh tĩnh nếu cần tự quản lý.

## A. Những thứ cần chuẩn bị
1. Một tài khoản Supabase miễn phí: https://supabase.com/
2. Một tài khoản GitHub: https://github.com/
3. Hosting miễn phí: GitHub Pages (dễ bắt đầu) hoặc Cloudflare Pages.
4. Không cần mua domain; URL miễn phí dạng `username.github.io/repository/`.

> Gói miễn phí có giới hạn dung lượng, băng thông và chính sách tạm dừng khi không hoạt động. Không nên upload ảnh gốc quá nặng. Tối ưu ảnh JPG/WebP trước khi tải.

## B. Tạo Supabase project
1. Đăng nhập Supabase → New project.
2. Đặt tên ví dụ `duong-phuong-wedding`.
3. Đặt database password và lưu ở nơi an toàn.
4. Chọn region gần Việt Nam nếu có lựa chọn phù hợp.
5. Sau khi tạo xong, vào Project Settings → API.
6. Sao chép **Project URL** và **anon/public key** (không dùng `service_role` key).
7. Mở `config.js`, thay:
   - `YOUR_SUPABASE_PROJECT_URL`
   - `YOUR_SUPABASE_ANON_KEY`

## C. Tạo bảng và bảo mật
1. Mở `supabase-schema.sql`.
2. Thay `YOUR_ADMIN_EMAIL@example.com` bằng đúng email bạn dùng để đăng nhập Admin.
3. Supabase → SQL Editor → New query.
4. Dán toàn bộ nội dung SQL đã thay email → Run.
5. Supabase → Authentication → Providers → Email: bật Email provider.
6. Authentication → Users → Add user → tạo user với email quản trị và mật khẩu mạnh.
7. Nếu có tùy chọn email confirmation, xác nhận email hoặc tắt confirmation trong giai đoạn thiết lập riêng tư.

Bảo mật:
- `anon/public key` được phép xuất hiện trong frontend; quyền thực tế được giới hạn bởi RLS.
- Tuyệt đối không đưa `service_role` key vào `config.js`, HTML hoặc GitHub.
- Không bật đăng ký công khai. Chỉ tạo user quản trị mà bạn kiểm soát.
- SQL policy chỉ cho đúng email đã cấu hình thao tác dữ liệu và upload/xóa ảnh.

## D. Chạy thử trên máy tính
1. Giải nén ZIP.
2. Mở `config.js`, điền Supabase URL và anon key.
3. Nên chạy qua local server thay vì mở file trực tiếp:
   - Cài VS Code (miễn phí) và extension Live Server; hoặc
   - Mở terminal trong thư mục, chạy `python -m http.server 5500`.
4. Truy cập `http://localhost:5500/`.
5. Admin: `http://localhost:5500/admin.html`.
6. Đăng nhập bằng user đã tạo ở Supabase Auth.

## E. Dùng Admin
1. **Cặp đôi**: tên, ngày cưới, ngày hiển thị.
2. **Mở thiệp**: lời mời, chữ con dấu.
3. **Hero**: upload ảnh, câu gõ chữ (mỗi dòng một câu), căn lề, vị trí ảnh, dịch chữ X/Y.
4. **Album ảnh**: upload nhiều ảnh, xóa ảnh.
5. **Ngày cưới**: giờ lễ, giờ tiệc, địa điểm, link Google Maps.
6. **Gia đình**: tên, mô tả và ảnh hai bên.
7. **Mini game**: sửa JSON câu hỏi/đáp án.
8. **Giao diện**: màu nền, màu chữ, màu nhấn, font CSS.
9. **Preview**: xem bản nháp trước khi công khai.
10. **Lưu bản nháp**: ghi dữ liệu nhưng khách chưa thấy nội dung mới.
11. **Xuất bản website**: công khai nội dung mới.

## F. Đưa website lên GitHub Pages miễn phí
1. Tạo GitHub repository mới, ví dụ `duong-phuong-wedding`.
2. Upload `index.html`, `admin.html`, `config.js` và các file còn lại ở thư mục gốc repository.
3. Repository → Settings → Pages.
4. Build and deployment → Deploy from a branch.
5. Chọn branch `main`, folder `/ (root)` → Save.
6. Đợi GitHub Pages triển khai, URL thường là `https://TEN-GITHUB.github.io/duong-phuong-wedding/`.
7. Mở URL website và `/admin.html` để kiểm tra.

Nếu dùng Cloudflare Pages: kết nối GitHub repository → Framework preset `None` → Build command để trống → Output directory `/` (root).

## G. Checklist trước khi gửi khách
- [ ] Đã thay ảnh mẫu bằng ảnh cưới thật.
- [ ] Đã kiểm tra tên, ngày và giờ.
- [ ] Đã nhập địa chỉ chính xác và link bản đồ.
- [ ] Đã thay câu hỏi mini game.
- [ ] Đã thử trên điện thoại và desktop.
- [ ] Đã kiểm tra quyền truy cập Admin và RLS.
- [ ] Đã bấm Xuất bản.
- [ ] Đã mở link ở cửa sổ ẩn danh để xác nhận khách xem được.

## H. Lưu ý và giới hạn phiên bản đầu
- Đây là website một cặp đôi, một bộ nội dung (phù hợp lựa chọn A).
- Admin hiện có đăng nhập Supabase Auth, dữ liệu lưu trong Supabase Postgres, ảnh lưu trong Supabase Storage.
- Preview dùng localStorage trên cùng trình duyệt; preview draft không được public.
- Hiệu ứng mở thiệp yêu cầu khách bấm nút, phù hợp quy định trình duyệt về âm thanh tự phát.
- Mini game hiện chấm điểm ngay trên trình duyệt, không thu thập/lưu tên hoặc kết quả khách mời.
- Font Google Fonts và ảnh demo trực tuyến cần internet. Thay ảnh mẫu bằng ảnh riêng trước khi gửi.
- Chưa tích hợp RSVP, gửi lời chúc lưu database, QR code tự động hoặc thống kê lượt xem; có thể bổ sung sau.
- Trước khi đưa dữ liệu cá nhân/ảnh gia đình lên mạng, hãy đảm bảo đã được người trong ảnh đồng ý.

## I. Kích thước ảnh đề xuất
| Vị trí | Kích thước khuyến nghị | Tỷ lệ |
|---|---:|---:|
| Hero desktop | 2400 × 1600 px | 3:2 |
| Hero cinematic | 2400 × 1350 px | 16:9 |
| Album ảnh chính | 2000 × 1400 px | 10:7 |
| Thumbnail album | 900 × 700 px | 9:7 |
| Ảnh gia đình | 1600 × 1200 px | 4:3 |
| Opening artwork (nếu thay nền) | 1600 × 2200 px | 8:11 |
| Avatar / seal artwork | 800 × 800 px | 1:1 |

Xuất JPG/WebP, chất lượng 75–85%, ưu tiên mỗi ảnh khoảng 200 KB–1.5 MB. Không kéo giãn ảnh; dùng ảnh đủ lớn và chọn đúng vùng lấy nét.
