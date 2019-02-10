uniform vec3 discoPosition;
uniform float discoRotationAngle;
out vec3 color;

void main() {
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0,1.0,0.0) * dot(l, normal);
	
	mat4 scaleMatrix = mat4(0.45, 0.0, 0.0, 0.0,
						  0.0, 0.45, 0.0, 0.0, 
						  0.0, 0.0, 0.45, 0.0,
						  0.0, 0.0, 0.0,  1.0);

		mat4 translationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
							          0.0, 1.0, 0.0, 0.0, 
							          0.0, 0.0, 1.0, 0.0,
							          0.0, 3.0, 2.0, 1.0);
    	
		float s = sin(discoRotationAngle);
		float c = cos(discoRotationAngle);
		  
		mat4 xRotationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
									0.0, c,    -s, 0.0, 
									0.0, s,     c, 0.0,
									0.0, 0.0, 0.0, 1.0);
        mat4 yRotationMatrix = mat4(  c, 0.0,  -s, 0.0,
									0.0, 1.0, 0.0, 0.0, 
									  s, 0.0,   c, 0.0,
									0.0, 0.0, 0.0, 1.0);
									
		mat4 rotationMatrix = yRotationMatrix;
		
		mat4 translationInverseMatrix = mat4(1.0, 0.0, 0.0, 0.0,
											 0.0, 1.0, 0.0, 0.0, 
											 0.0, 0.0, 1.0, 0.0,
											 0.0, -2.0, -2.0, 1.0);						  

	vec4 newPosition = translationMatrix * rotationMatrix * translationInverseMatrix * (vec4(position, 1.0) + vec4(discoPosition, 0.0));										 
    gl_Position = projectionMatrix * modelViewMatrix * scaleMatrix * newPosition;
}