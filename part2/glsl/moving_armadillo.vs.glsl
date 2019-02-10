// Shared variable passed to the fragment shader
out vec3 color;

// rotation angle gets updated 
// Constant set via your javascript code
uniform float rot_angle;
uniform float armRotationAngle;
uniform float leftLegRotationAngle;
uniform float rightLegRotationAngle;

void main() {
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);
	
	vec4 newPosition = vec4(position, 1.0);

    //Identifying the head
	if (position.z < -0.33 && abs(position.x) < 0.46) {
		
		mat4 translationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
							          0.0, 1.0, 0.0, 0.0, 
							          0.0, 0.0, 1.0, 0.0,
							          0.0, 2.5, -0.25, 1.0);
    	
		float s = sin(rot_angle);
		float c = cos(rot_angle);
		mat4 xRotationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
									0.0, c,    -s, 0.0,
									0.0, s,     c, 0.0,
									0.0, 0.0, 0.0, 1.0);
//        mat4 yRotationMatrix = mat4(  c, 0.0,  -s, 0.0,
//									0.0, 1.0, 0.0, 0.0,
//									  s, 0.0,   c, 0.0,
//									0.0, 0.0, 0.0, 1.0);
		mat4 rotationMatrix = xRotationMatrix;
		
		mat4 translationInverseMatrix = inverse(translationMatrix);

		newPosition = translationMatrix * rotationMatrix * translationInverseMatrix * newPosition;					  
	}
	
	// Identifying the arms
	if (abs(position.x) > 0.55 && position.y > 0.5) {

		mat4 armTranslationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
									     0.0, 1.0, 0.0, 0.0,
										 0.0, 0.0, 1.0, 0.0,
										 0.55, 2.0, 0.2, 1.0);

		float s = sin(armRotationAngle);
		float c = cos(armRotationAngle);
		
		mat4 xRotateArm = mat4(1.0, 0.0, 0.0, 0.0,
							   0.0, c,    -s, 0.0, 
							   0.0, s,     c, 0.0,
							   0.0, 0.0, 0.0, 1.0);

	    mat4 armTranslationInverseMatrix = inverse (armTranslationMatrix);



		newPosition = armTranslationMatrix * xRotateArm * armTranslationInverseMatrix * newPosition;
	}
	
	
	// Identifying the left leg
	if (position.x < -0.2 && position.y < 0.4) {

			
		mat4 leftLegTranslationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
											 0.0, 1.0, 0.0, 0.0,
										 	 0.0, 0.0, 1.0, 0.0,
										     0.15, 0.5, 0.1, 1.0);

		float s = sin(leftLegRotationAngle);
		float c = cos(leftLegRotationAngle);
		
							 
		mat4 xRotateLeftLeg = mat4(1.0, 0.0, 0.0, 0.0,
							   0.0, c,    s, 0.0, 
							   0.0, -s,     c, 0.0,
							   0.0, 0.0, 0.0, 1.0);
							   
	    mat4 leftLegTranslationInverseMatrix = inverse(leftLegTranslationMatrix);


		newPosition = leftLegTranslationMatrix *xRotateLeftLeg * leftLegTranslationInverseMatrix * newPosition;
	}
	
	// Identifying the right leg
	if (position.x > 0.15 && position.y < 0.4) {

		mat4 rightLegTranslationMatrix = mat4(1.0, 0.0, 0.0, 0.0,
											 0.0, 1.0, 0.0, 0.0,
										 	 0.0, 0.0, 1.0, 0.0,
										     0.15, 0.5, 0.1, 1.0);

		float s = sin(rightLegRotationAngle);
		float c = cos(rightLegRotationAngle);
		
							 
		mat4 xRotateRightLeg = mat4(1.0, 0.0, 0.0, 0.0,
							   0.0, c,    s, 0.0, 
							   0.0, -s,     c, 0.0,
							   0.0, 0.0, 0.0, 1.0);
							   
	    mat4 rightLegTranslationInverseMatrix = inverse(rightLegTranslationMatrix);


		newPosition = rightLegTranslationMatrix *xRotateRightLeg * rightLegTranslationInverseMatrix * newPosition;
	}

	
	
	// Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * newPosition;
}
