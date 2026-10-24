/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Vazirmatn', 'system-ui', 'sans-serif'],
      },
      colors: {
        brand: {
          50: '#eef7f4',
          100: '#d6ece4',
          200: '#aed9ca',
          300: '#7cc0a9',
          400: '#4ea58a',
          500: '#2f8a6e',
          600: '#227058',
          700: '#1c5a48',
          800: '#17483b',
          900: '#123b31',
        },
      },
      boxShadow: {
        card: '0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04)',
        cardHover: '0 4px 12px rgba(0,0,0,0.08), 0 2px 6px rgba(0,0,0,0.05)',
      },
    },
  },
  plugins: [],
};
