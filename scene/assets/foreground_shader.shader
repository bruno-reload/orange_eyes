shader_type canvas_item;

uniform sampler2D line_mask :hint_albedo;
uniform sampler2D quad_mask :hint_albedo;

void fragment(){
	vec4 col = texture(line_mask,SCREEN_UV);
	vec4 quad = texture(quad_mask, SCREEN_UV);
	
	if (col.a >= 0.5){
		COLOR *= vec4(vec3(1.0),0.0);
	}
	if (quad.x <= 0.5 ){
		COLOR *= vec4(vec3(1.0),0.0);
	}
}