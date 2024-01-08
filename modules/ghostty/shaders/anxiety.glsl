/**
 Just messing around with different types of glitching effects.
*/

// try commenting/uncommenting these to isolate/combine different glitch effects.
#define ANALOG
#define DIGITAL

// amount of seconds for which the glitch loop occurs
#define DURATION 2.
// percentage of the duration for which the glitch is triggered
#define AMT .5 

#define SS(a, b, x) (smoothstep(a, b, x) * smoothstep(b, a, x))

#define UI0 1597334673U
#define UI1 3812015801U
#define UI2 uvec2(UI0, UI1)
#define UI3 uvec3(UI0, UI1, 2798796415U)
#define UIF (1. / float(0xffffffffU))

// https://stackoverflow.com/a/10625698
float random(vec2 p)
{
    vec2 K1 = vec2(23.14069263277926f, // e^pi (Gelfond's constant)
                       2.665144142690225f // 2^sqrt(2) (Gelfondâ€“Schneider constant)
    );
    return fract(cos(dot(p, K1)) * 12345.6789f);
}

// Hash by David_Hoskins
vec3 hash33(vec3 p)
{
	uvec3 q = uvec3(ivec3(p)) * UI3;
	q = (q.x ^ q.y ^ q.z)*UI3;
	return -1. + 2. * vec3(q) * UIF;
}

// Gradient noise by iq
float gnoise(vec3 x)
{
    // grid
    vec3 p = floor(x);
    vec3 w = fract(x);
    
    // quintic interpolant
    vec3 u = w * w * w * (w * (w * 6. - 15.) + 10.);
    
    // gradients
    vec3 ga = hash33(p + vec3(0., 0., 0.));
    vec3 gb = hash33(p + vec3(1., 0., 0.));
    vec3 gc = hash33(p + vec3(0., 1., 0.));
    vec3 gd = hash33(p + vec3(1., 1., 0.));
    vec3 ge = hash33(p + vec3(0., 0., 1.));
    vec3 gf = hash33(p + vec3(1., 0., 1.));
    vec3 gg = hash33(p + vec3(0., 1., 1.));
    vec3 gh = hash33(p + vec3(1., 1., 1.));
    
    // projections
    float va = dot(ga, w - vec3(0., 0., 0.));
    float vb = dot(gb, w - vec3(1., 0., 0.));
    float vc = dot(gc, w - vec3(0., 1., 0.));
    float vd = dot(gd, w - vec3(1., 1., 0.));
    float ve = dot(ge, w - vec3(0., 0., 1.));
    float vf = dot(gf, w - vec3(1., 0., 1.));
    float vg = dot(gg, w - vec3(0., 1., 1.));
    float vh = dot(gh, w - vec3(1., 1., 1.));
	
    // interpolation
    float gNoise = va + u.x * (vb - va) + 
           		u.y * (vc - va) + 
           		u.z * (ve - va) + 
           		u.x * u.y * (va - vb - vc + vd) + 
           		u.y * u.z * (va - vc - ve + vg) + 
           		u.z * u.x * (va - vb - ve + vf) + 
           		u.x * u.y * u.z * (-va + vb + vc - vd + ve - vf - vg + vh);
    
    return 2. * gNoise;
}

// gradient noise in range [0, 1]
float gnoise01(vec3 x)
{
	return .5 + .5 * gnoise(x);   
}

// warp uvs for the crt effect
vec2 crt(vec2 uv)
{
    float tht  = atan(uv.y, uv.x);
    float r = length(uv);
    // curve without distorting the center
    r /= (1. - .1 * r * r);
    uv.x = r * cos(tht);
    uv.y = r * sin(tht);
    return .5 * (uv + 1.);
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec4 screen_res = vec4(iResolution.xy, 1.0 / iResolution.xy);
    vec2 texcoord = fragCoord * screen_res.zw;

    vec2 uv = texcoord;
    float t = iTime;
    
    // smoothed interval for which the glitch gets triggered
    float glitchAmount = SS(DURATION * .01, DURATION * AMT, mod(random(vec2(0.0, t)), DURATION)) / 2.0;  
    vec3 col = vec3(0.);
    vec2 eps = vec2(5. / screen_res.x, 0.);
    vec2 st = vec2(0.);

    // analog distortion
    float y = uv.y * screen_res.y;
    float distortion = gnoise(vec3(0., y * .01, t * 500.)) * (glitchAmount * 4. + .1);
    distortion *= gnoise(vec3(0., y * .02, t * 250.)) * (glitchAmount * 2. + .025);
    
#ifdef ANALOG
    distortion += smoothstep(.999, 1., sin((uv.y + t * 1.6) * 2.)) * .02;
    distortion -= smoothstep(.999, 1., sin((uv.y + t) * 2.)) * .02;
    st = uv + vec2(distortion, 0.);
    // chromatic aberration
    col.r += textureLod(iChannel0, st + eps + distortion, 1.).r;
    col.g += textureLod(iChannel0, st, 0.).g;
    col.b += textureLod(iChannel0, st - eps - distortion, 1.).b;
#else
    col += texture(iChannel0, uv, 0.).xyz;
#endif
    
#ifdef DIGITAL
    // blocky distortion
    float bt = floor(t * 30.) * 300.;
    float blockGlitch = .2 + .9 * glitchAmount;
    float blockNoiseX = step(gnoise01(vec3(0., uv.x * 3., bt)), blockGlitch);
    float blockNoiseX2 = step(gnoise01(vec3(0., uv.x * 1.5, bt * 1.2)), blockGlitch);
    float blockNoiseY = step(gnoise01(vec3(0., uv.y * 4., bt)), blockGlitch);
    float blockNoiseY2 = step(gnoise01(vec3(0., uv.y * 6., bt * 1.2)), blockGlitch);
    float block = blockNoiseX2 * blockNoiseY2 + blockNoiseX * blockNoiseY;
    st = vec2(uv.x + sin(bt) * hash33(vec3(uv, .5)).x, uv.y);
    col *= 1. - block;
    block *= 1.15;
    col.r += textureLod(iChannel0, st + eps, 1.).r * block;
    col.g += textureLod(iChannel0, st, 0.).g * block;
    col.b += textureLod(iChannel0, st - eps, 1.).b * block;
#endif

    fragColor = vec4(col, 1.0);
}
