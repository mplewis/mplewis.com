/** @type {import('tailwindcss').Config} */
export default {
  content: ["./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}"],
  theme: {
    fontFamily: {
      serif: ["Optima", "serif"],
    },
    fontWeight: {
      normal: 400,
      bold: 700,
    },
  },
  plugins: [require("@tailwindcss/typography")],
};
