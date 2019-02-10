#version 300 es

// Create shared variable for the vertex and fragment shaders
out vec3 interpolatedNormal;
out float intensity;

uniform vec3 bunnyPosition;
uniform vec3 lightPosition;
uniform vec3 eggPosition;
uniform vec3 armadilloPosition;

void main() {
    // Calculate position in world coordinates
    vec4 wpos = modelMatrix * vec4(position, 1.0) + vec4(bunnyPosition, 0.0);

    // Calculates vector from the vertex to the light
    vec3 l = lightPosition - wpos.xyz;

    // Calculates the intensity of the light on the vertex
    intensity = dot(normalize(l), normal);

    // Use normal as the color, pass is to fragment shader
    interpolatedNormal = normal;

    // Scale matrix
    mat4 S = mat4(10.0);
    S[3][3] = 1.0;

    /* You need to calculate rotation matrix here */

    // Translation matrix
    mat4 T = mat4(1.0);
    T[3].xyz = bunnyPosition;

      float angle = 2.0;
      float s = sin(angle);
      float c = cos(angle);

        // rotate around y-axis
        mat4 rotationMatrix = mat4(  c, 0.0,  -s, 0.0,
                                    0.0, 1.0, 0.0, 0.0,
                                      s, 0.0,   c, 0.0,
                                    0.0, 0.0, 0.0, 1.0);
         // lookAt Matrix
          vec3 up = vec3(0.0, 1.0, 0.0);
          vec3 z = normalize(armadilloPosition - eggPosition);
          vec3 x = normalize(cross(up, z));
          vec3 y = cross(z, x);
          mat4 lookAtMatrix = mat4(vec4(x,0.0), vec4(y,0.0), vec4(z,0.0), vec4(eggPosition, 1.0));

        gl_Position = projectionMatrix * viewMatrix * lookAtMatrix * rotationMatrix * T * S * vec4(position, 1.0);
}
