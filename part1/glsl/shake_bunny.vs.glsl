#version 300 es

// Shared variable passed to the fragment shader
out float segment;
out vec3 interpolatedNormal;

uniform float rot_angle;
uniform vec3 bunnyPosition;

void main() {
    // Colorize bunny use the normal
    interpolatedNormal = normal;

    // Provided information, do not need to change
    vec3 o_left_ear = vec3(-0.055, 0.155, 0.0126); // origin for the left ear frame
    vec3 t_left_ear = vec3(-0.0111, 0.182, -0.028); // the top point on the left ear
    vec3 o_right_ear = vec3(-0.077, 0.1537, -0.0023); // origin for the right ear frame
    vec3 t_right_ear = vec3(-0.0678, 0.18, -0.058); // the top point on the right ear
    vec3 normal_left_ear = t_left_ear-o_left_ear; // approximated normal from the origin of the left ear frame
    vec3 normal_right_ear = t_right_ear-o_right_ear; // approximated normal from the origin of the right ear frame

    // Scale matrix
    mat4 S = mat4(10.0);
    S[3][3] = 1.0;

    // Translation matrix
    mat4 T = mat4(1.0);
    T[3].xyz = bunnyPosition;



    // Identifying the ear
    vec3 newPosition = position;

    float theta = 0.7;


    vec3 to_right_origin = normalize(position - o_right_ear);
    if(dot(to_right_origin, normalize(normal_right_ear))> cos(theta)){
        segment = 1.0;

        mat4 A = mat4(1.0);
        A[3].xyz = o_right_ear;
        float newAngle = cos(rot_angle-1.2);

     mat4 R = mat4(vec4(cos(newAngle), 0.0, -sin(newAngle), 0.0),
                               vec4(0.0, 1.0, 0.0, 0.0),
                               vec4(sin(newAngle), 0.0, cos(newAngle), 0.0),
                               vec4(0.0, 0.0, 0.0, 1.0));

    newPosition = vec3(A*R*inverse(A)*vec4(newPosition, 1.0));
    }

    vec3 to_left_origin = normalize(position - o_left_ear);
    if(dot(to_left_origin, normalize(normal_left_ear))> cos(theta)){
        segment = 1.0;

        mat4 A = mat4(1.0);
        A[3].xyz = o_left_ear;
        float newAngle = cos(rot_angle-1.2);

     mat4 R = mat4(vec4(cos(newAngle), 0.0, -sin(newAngle), 0.0),
                               vec4(0.0, 1.0, 0.0, 0.0),
                               vec4(sin(newAngle), 0.0, cos(newAngle), 0.0),
                               vec4(0.0, 0.0, 0.0, 1.0));

    newPosition = vec3(A*R*inverse(A)*vec4(newPosition, 1.0));
    }




    gl_Position = projectionMatrix * viewMatrix * T*S*vec4(newPosition, 1.0);
}
