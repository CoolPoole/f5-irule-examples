# Information provided by https://devcentral.f5.com/codeshare/security-headers-insertion
# Used to pass vulnerability scanners as F5 ASM response pages provide 200 OK with no security headers
# Vulnerability scanners think they've hit the thing but really were blocked

when HTTP_RESPONSE {

	#X-XSS-Protection
	HTTP::header insert X-XSS-Protection "1; mode=block"

	#X-Frame-Options
	HTTP::header insert X-Frame-Options "SAMEORIGIN"

	#X-Content-Type-Options
	HTTP::header insert X-Content-Type-Options "nosniff"

	#CSP
	HTTP::header insert Content-Security-Policy "default-src 'self'; img-src *.nano.com *.cloudfront.net *.vi.com *.nvim.com *.pico.us; script-src https://bam.nr-data.net 'nonce-5XVOskmSBTwHDfTMmfqnNpY2' *.bootstrapcdn.com *.vi.com; style-src 'unsafe-inline' https://fonts.google.com https://fonts.googleapis.com *.cloudfront.net *.bootstrapcdn.com *.vi.com; font-src https://fonts.gstatic.com *.bootstrapcdn.com *.vi.com; connect-src 'self'  https://bam.nr-data.net/ https://*.hotjar.io https://tracker.local https://googletagmanager.com https://fonts.gstatic.com https://weloveaws.s3.amazonaws.com/*"
    
}
