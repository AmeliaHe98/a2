out vec3 color;
uniform vec3 offset;
uniform vec3 armadilloPosition;
uniform vec3 eggPosition;

#define MAX_EYE_DEPTH 0.05

void main() {
  // simple way to color the pupil where there is a concavity in the sphere
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);

  mat4 S = mat4(0.1);
  S[3][3] = 1.0;

  /* YOUR CODES HERE: move and rotate eyes corresponding to the movement of armadillo */

  mat4 T = mat4(1.0);
  T[3].xyz = vec3(armadilloPosition.x+offset.x,offset.y, armadilloPosition.z+offset.z);

      // rotate the eye
    float angle = 1.5708;
    float s = sin(angle);
    float c = cos(angle);

      // rotate around x-axis
      mat4 xRotationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
                                  0.0, c,    -s, 0.0,
                                  0.0, s,     c, 0.0,
                                  0.0, 0.0, 0.0, 1.0);
      // rotate around y-axis
      mat4 rotationMatrix = xRotationMatrix;

       //lookAt Matrix
       vec3 eyePosition = armadilloPosition+offset;
        vec3 up = vec3(0.0, 1.0, 0.0);
        vec3 z = normalize(eyePosition-eggPosition);
        vec3 x = normalize(cross(up, z));
        vec3 y = cross(z, x);
        mat4 lookAtMatrix = mat4(vec4(x,0.0), vec4(y,0.0), vec4(z,0.0), vec4(0.0,0.0,0.0, 1.0));

  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
  //gl_Position = projectionMatrix * viewMatrix * T * S * vec4(position, 1.0);
   gl_Position = projectionMatrix * viewMatrix *T*lookAtMatrix*rotationMatrix * S * vec4(position, 1.0);
}
