float scan = 0.75; // simulate darkness between scanlines

void mainImage(out vec4 fragColor,in vec2 fragCoord)
	{
    // squared distance from center
    vec2 uv = fragCoord/iResolution.xy;
    vec2 dc = abs(0.5-uv);
    dc *= dc;

    // sample inside boundaries, otherwise set to black
    if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0)
        fragColor = vec4(0.0,0.0,0.0,1.0);
    else
    	{
        // determine if we are drawing in a scanline
        float apply = abs(sin(fragCoord.y)*0.5*scan);
        // sample the texture
    	fragColor = vec4(mix(texture(iChannel0,uv).rgb,vec3(0.0),apply),1.0);
        }
	}
