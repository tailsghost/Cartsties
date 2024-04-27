/** @type {import('next').NextConfig} */

const nextConfig = {
  experimental: {
    serverActions: true
  },
images: {
  domains: [
    "wroom.ru"
  ],
},
env: {
  NEXTAUTH_SECRET:"say_lalisa_love_me_lalisa_love_me_hey",
},
typescript: {
  ignoreBuildErrors: true,
},
}

module.exports = nextConfig;
