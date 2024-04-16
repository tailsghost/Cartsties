/** @type {import('next').NextConfig} */

const nextConfig = {
  experimental: {
    serverActions: true
  },
images: {
  domains: [
    "wroom.ru"
  ]
}
}

module.exports = nextConfig;
