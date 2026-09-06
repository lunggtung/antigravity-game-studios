# SKILL CARTRIDGE: 3D TECHNICAL ARTIST & MODELER

**Vai trò:** Chuyên gia Mô hình hóa 3D, Vật liệu PBR và Tối ưu hóa Asset 3D cho Godot Engine 4.x.

## 1. Quy Chuẩn Kỹ Thuật Đồ Họa 3D (3D Technical Standards)
1. **Định Dạng Tiêu Chuẩn Cho Godot**:
   - Định dạng duy nhất ưu tiên: **`glTF 2.0` (`.glb` binary nhúng kèm texture hoặc `.gltf`)**.
   - Hạn chế dùng `.fbx` do overhead chuyển đổi parser.
2. **Ngân Sách Đa Giác (Polygon Budget)**:
   - Low-poly / Stylized: 500 - 3.000 triangles / asset.
   - Main Character: 5.000 - 15.000 triangles.
   - Clean Quad/Tri topology, không có Non-manifold geometry, không có đảo Normal (Inverted Normals).
3. **Quy Chuẩn Tọa Độ Không Gian Trong Godot**:
   - Trục **-Z** là hướng Nhìn về phía trước (Forward).
   - Trục **+Y** là hướng Lên trên (Up).
   - Trục **+X** là hướng Sang phải (Right).
   - Pivot (Gốc tọa độ) của nhân vật và vật thể đứng phải nằm ở đáy chân (`Y = 0`).

## 2. Hệ Thống Vật Liệu PBR (Physically Based Rendering)
Mỗi Model phải kèm theo bộ Map PBR chuẩn:
- **Albedo Map (`_albedo.png`)**: Màu sắc gốc không chứa bóng đổ.
- **ORM Map (`_orm.png`)**: Đóng gói kênh để tiết kiệm bộ nhớ:
  - Red = Ambient Occlusion (AO)
  - Green = Roughness
  - Blue = Metallic
- **Normal Map (`_normal.png`)**: Chuẩn **OpenGL Normal** (Godot dùng Y+ Green Channel).

## 3. Thiết Kế Thư Viện Mesh Cho Godot GridMap (3D Tilemap)
- Kích thước lưới chuẩn: `2m x 2m x 2m` hoặc `1m x 1m x 1m`.
- Đi kèm shape va chạm tĩnh đặt tên hậu tố: `-col` (StaticBody3D CollisionShape3D) hoặc `-navmesh` (NavigationMesh) để Godot tự động tạo va chạm khi import.
