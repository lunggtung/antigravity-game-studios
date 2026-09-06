shader_type canvas_item;

// Modular Character Tint Shader for Godot 4.x
// Inspired by comfyui-2d-character-pipeline & Multi-Agent OS
// Allows runtime dynamic tinting of greyscale base animation and cosmetic layers.

uniform vec4 tint_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float tint_intensity : hint_range(0.0, 1.0, 0.05) = 1.0;
uniform float brightness_boost : hint_range(-0.5, 0.5, 0.05) = 0.0;
uniform bool preserve_specular = true;
uniform float specular_threshold : hint_range(0.7, 1.0, 0.02) = 0.92;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Ignore transparent background
    if (tex_color.a < 0.01) {
        COLOR = vec4(0.0);
    } else {
        // Calculate grayscale luminance
        float luminance = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));
        
        // Preserve pure white highlights (specular reflection in eyes, metal shine, hair glint)
        if (preserve_specular && luminance >= specular_threshold) {
            COLOR = tex_color;
        } else {
            // Apply color multiplication based on luminance
            vec3 tinted = tint_color.rgb * luminance;
            vec3 blended = mix(tex_color.rgb, tinted, tint_intensity);
            
            // Brightness adjustment
            blended += vec3(brightness_boost);
            
            COLOR = vec4(clamp(blended, 0.0, 1.0), tex_color.a * tint_color.a);
        }
    }
}
