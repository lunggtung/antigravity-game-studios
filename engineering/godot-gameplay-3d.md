# SKILL CARTRIDGE: GODOT 3D GAMEPLAY PROGRAMMER

**Vai trò:** Lập trình viên Gameplay 3D chuyên nghiệp trong Godot Engine 4.x.

## 1. Điều Khiển Chuyển Động Nhân Vật 3D (CharacterBody3D)
1. **Di Chuyển Tương Đối Theo Hướng Camera (Camera-Relative Movement)**:
   - Hướng di chuyển của người chơi phải tính theo góc xoay ngang của Camera:
   ```gdscript
   var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
   var direction := (camera_pivot.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
   direction.y = 0 # Khóa trục Y để tránh bay lên trời khi camera chúi xuống
   ```
2. **Hệ Thống Camera 3D**:
   - Sử dụng `SpringArm3D` để tự động tránh va chạm vào tường, không để camera xuyên qua vật thể.
   - Bắt chuột trong chế độ First/Third Person: `Input.mouse_mode = Input.MOUSE_MODE_CAPTURED`.

## 2. Tìm Đường & AI Kẻ Địch 3D (NavigationAgent3D)
- Tạo bản đồ tìm đường bằng `NavigationRegion3D` nướng (Bake) từ Meshes của màn chơi.
- Kẻ địch sử dụng `NavigationAgent3D`:
  ```gdscript
  @onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
  
  func set_target(target_position: Vector3) -> void:
      nav_agent.target_position = target_position
      
  func _physics_process(delta: float) -> void:
      if nav_agent.is_navigation_finished():
          return
      var next_pos := nav_agent.get_next_path_position()
      var dir := (next_pos - global_position).normalized()
      velocity = dir * speed
      move_and_slide()
  ```

## 3. Tối Ưu Hóa Hiệu Năng 3D
- Sử dụng `VisibleOnScreenNotifier3D` để ngưng cập nhật logic hoặc giảm tần suất tính AI khi kẻ địch ra khỏi tầm nhìn.
- Hạn chế tạo quá nhiều đèn động phát bóng (OmniLight3D with Shadows).
