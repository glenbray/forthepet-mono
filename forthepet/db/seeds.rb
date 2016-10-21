require 'securerandom'

CouponCode.all.each { |c| c.destroy }
Coupon.all.each { |c| c.destroy }

coupon = Coupon.create(title: '20 off', description: '$20 off', percent: nil, amount: 20, starts_at: Time.now, expires_at: nil)

coupon.coupon_codes.create(code: 'f79f2bd6a5')
coupon.coupon_codes.create(code: '915bd76884')
coupon.coupon_codes.create(code: '51fadf1eea')
coupon.coupon_codes.create(code: 'b3ca6bb385')
coupon.coupon_codes.create(code: '09f28aa00a')
coupon.coupon_codes.create(code: 'f0c7957d')
coupon.coupon_codes.create(code: '7aff9d82fc')
coupon.coupon_codes.create(code: '99b563f509')
coupon.coupon_codes.create(code: 'f0a249c124')
coupon.coupon_codes.create(code: 'a2cc90258a')
coupon.coupon_codes.create(code: 'a5b13c6116')
coupon.coupon_codes.create(code: '7afe03b315')
coupon.coupon_codes.create(code: '15f89663ae')
coupon.coupon_codes.create(code: 'e60da5f52b')
coupon.coupon_codes.create(code: 'a76c9059e1')
coupon.coupon_codes.create(code: '0da4899d21')
coupon.coupon_codes.create(code: 'fa8115c88c')
coupon.coupon_codes.create(code: 'f8d4739f9a')
coupon.coupon_codes.create(code: '25f6152d1f')
coupon.coupon_codes.create(code: 'dc689890ef')
coupon.coupon_codes.create(code: '3152f5dbaf')
coupon.coupon_codes.create(code: 'c3dafbc9aa')
coupon.coupon_codes.create(code: '40558d0c55')
coupon.coupon_codes.create(code: 'd3937d1934')
