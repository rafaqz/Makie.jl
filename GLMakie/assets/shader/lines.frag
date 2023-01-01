{{GLSL_VERSION}}
{{GLSL_EXTENSIONS}}
{{SUPPORTED_EXTENSIONS}}

struct Nothing{ //Nothing type, to encode if some variable doesn't contain any data
    bool _; //empty structs are not allowed
};

in vec4 f_color;
in vec2 f_uv;
in float f_thickness;
flat in uvec2 f_id;
flat in int f_type; // TODO bad for performance
{{pattern_type}} pattern;

uniform float pattern_length;

const float ALIASING_CONST = 0.9;

float aastep(float threshold1, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * ALIASING_CONST;
    return smoothstep(threshold1-afwidth, threshold1+afwidth, value);
}
float aastep(float threshold1, float threshold2, float value) {
    float afwidth = length(vec2(dFdx(value), dFdy(value))) * ALIASING_CONST;
    return smoothstep(threshold1-afwidth, threshold1+afwidth, value)-smoothstep(threshold2-afwidth, threshold2+afwidth, value);
}
void write2framebuffer(vec4 color, uvec2 id);

// Signed distance fields for lines
// x/y pattern
float get_sd(sampler2D pattern, vec2 uv){
    return texture(pattern, uv).x;
}
uniform float maxlength;
// x pattern
vec2 get_sd(sampler1D pattern, vec2 uv){
    return vec2(texture(pattern, uv.x).x, uv.y);
}
// normal line type
vec2 get_sd(Nothing _, vec2 uv){
    return vec2(0.5, uv.y);
}

// Signed distance fields for caps
#define LINE              0
#define CIRCLE            4
#define RECTANGLE         5

float circle(vec2 uv){
    // Radius 0.5 circle centered at (0.5, 0.5)
    return 0.5-length(uv - vec2(0.5));
}


void main(){
    vec4 color = vec4(f_color.rgb, 0.0);
    if (f_type == CIRCLE){
        float sd = f_thickness * circle(f_uv);
        color = mix(color, f_color, smoothstep(-ALIASING_CONST, ALIASING_CONST, sd));
    } else {
        vec2 xy = get_sd(pattern, f_uv);
        float alpha = aastep(0, xy.x);
        float alpha2 = aastep(-f_thickness, f_thickness, xy.y);
        color = vec4(f_color.rgb, f_color.a*alpha*alpha2);
    }
    write2framebuffer(color, f_id);
}
