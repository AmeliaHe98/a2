// Shared variable passed to the fragment shader
uniform vec3 offset;
uniform vec3 eggPosition;
uniform vec3 armadilloPosition;

void main() {
// simple way to color the pupil where there is a concavity in the sphere


  /* YOUR CODES HERE: move and rotate eyes corresponding to the movement of armadillo */

  mat4 T = mat4(1.0);
  T[3].xyz = vec3(armadilloPosition.x+offset.x,offset.y, armadilloPosition.z+offset.z);

      // rotate the eye
    float angle = 1.5708;
    float s = sin(angle);
    float c = cos(angle);

      // rotate around x-axis
      mat4 xRotationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
                                  0.0, cos(angle),    -sin(angle), 0.0,
                                  0.0, sin(angle),     cos(angle), 0.0,
                                  0.0, 0.0, 0.0, 1.0);
      // rotate around y-axis
      mat4 rotationMatrix = xRotationMatrix;

       //lookAt Matrix
       vec3 eyePosition = armadilloPosition+offset;
       vec3 eggPositionModified = vec3(eggPosition.x+0.05, eggPosition.y+1.0, eggPosition.z+0.05);
        vec3 up = vec3(0.0, 1.0, 0.0);
        vec3 z = normalize(eyePosition-eggPositionModified);
        vec3 x = normalize(cross(up, z));
        vec3 y = cross(z, x);
        mat4 lookAtMatrix = mat4(vec4(x,0.0), vec4(y,0.0), vec4(z,0.0), vec4(0.0,0.0,0.0, 1.0));

vec3 distance = eyePosition-eggPosition;
 mat4 S = mat4(1.0);
  S[1][1] = length(distance)*0.48;
  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
  //gl_Position = projectionMatrix * viewMatrix * T * S * vec4(position, 1.0);
   gl_Position = projectionMatrix * viewMatrix *T*lookAtMatrix*rotationMatrix * S * vec4(position, 1.0);
   }
