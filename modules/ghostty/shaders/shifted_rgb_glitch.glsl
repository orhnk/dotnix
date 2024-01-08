void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float brightness = 1.0;
    vec2 uv = fragCoord/iResolution.xy;
    //vec2 uvA = 2.*uv -1.;
    //uvA.x *= iResolution.x/iResolution.y; // adjusted uv
    
    vec4 img = texture(iChannel0, vec2(uv.x + 0.01 // adjust to change the shift
                                                ,uv.y));
    vec4 img2 = texture(iChannel0, vec2(uv.x + 0.
                                                ,uv.y));
    vec4 img3 = texture(iChannel0, vec2(uv.x - 0.01
                                                , uv.y));
    float lines = abs(sin(300.*uv.y +iTime)) *brightness;
    
    
    img.xyz *= vec3(1.,0.,0.); // red
    img2.xyz *= vec3(0.,1.,0.); // green
    img3.xyz *= vec3(0.,0.,1.); // blue
    vec3 col = img.xyz+img2.xyz+img3.xyz;
    
    //col -= smoothstep(0.,10.,length(uvA));
    //col*= lines; // put up the pixels
    // Output to screen
    fragColor = vec4( col,1.0);
}
