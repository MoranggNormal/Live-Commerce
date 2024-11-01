// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/live_commerce_web.ex",
    "../lib/live_commerce_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        brand: "#FD4F00",
        "primary": "#403BC9",
        "art-bg": "#f5f5f5",
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    plugin(function({ addComponents, theme }) {
      addComponents({
        '.report-card': {
          '@apply transition-all ease-in-out duration-300': {},

          '&:hover .card': {
            '@apply shadow-lg border-white': {},
            'transform': 'scale(1.01)',
          },
          '&:hover .footer': {
            '@apply p-0 border-0': {},
          },

          '.footer, .card': {
            '@apply transition-all ease-in-out duration-300': {},
          },
        },
      });
    }),

    plugin(function({ addComponents, theme }) {
      addComponents({
        '.card': {
          '@apply rounded-[0.35rem] bg-white border border-primary/10': {},
        },
        '.card-header': {
          '@apply border-b p-6': {},
        },
        '.card-body': {
          '@apply p-6': {},
        },
        '.card-footer': {
          '@apply border-t p-6': {},
        },
      });
    }),

    plugin(function({ addComponents }) {
      addComponents({
        'body, h1, h2, h3, h4, h5, h6, p, a': {
          '@apply capitalize': {},
        },
        'p': {
          '@apply tracking-wider text-sm text-gray-500': {},
        },
        '.h1': {
          '@apply text-6xl font-black': {},
        },
        '.h2': {
          '@apply text-5xl font-extrabold': {},
        },
        '.h3': {
          '@apply text-4xl font-extrabold': {},
        },
        '.h4': {
          '@apply text-3xl font-extrabold': {},
        },
        '.h5': {
          '@apply text-2xl font-extrabold': {},
        },
        '.h6': {
          '@apply text-xl font-extrabold': {},
        },
      });
    }),

    plugin(function({ addComponents, addVariant, e, theme }) {
      addComponents({
        '.btn-shadow': {
          '@apply text-center capitalize bg-primary block py-2 px-5 rounded text-white transition-all ease-in-out duration-300 shadow-md': {},
          '&:hover': {
            '@apply shadow-lg': {},
          },
        },
        '.btn': {
          '@apply text-center capitalize bg-primary block py-2 px-5 rounded text-white transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply bg-primary text-teal-800': {},
          },
        },
        '.btn-indigo': {
          '@apply text-center capitalize bg-indigo-500 text-indigo-100 block py-2 px-5 rounded transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply bg-indigo-600 text-indigo-200': {},
          },
        },
        '.btn-info': {
          '@apply text-center capitalize bg-yellow-300 text-yellow-600 block py-2 px-5 rounded transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply bg-yellow-400 text-yellow-600': {},
          },
        },
        '.btn-danger': {
          '@apply text-center capitalize bg-red-300 text-red-600 block py-2 px-5 rounded transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply bg-red-400 text-red-600': {},
          },
        },
        '.btn-gray': {
          '@apply text-center capitalize bg-gray-100 border border-gray-300 block py-2 px-5 rounded text-gray-600 transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply bg-white text-gray-800 border border-gray-300': {},
          },
        },
        '.btn-bs-dark': {
          '@apply text-center capitalize bg-gray-900 text-white block py-2 px-5 rounded transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply opacity-75': {},
          },
        },
        '.btn-bs-primary': {
          '@apply text-center capitalize bg-indigo-600 text-white block py-2 px-5 rounded transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply opacity-75': {},
          },
        },
        '.btn-bs-secondary': {
          '@apply text-center capitalize bg-gray-500 text-white block py-2 px-5 rounded transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply opacity-75': {},
          },
        },
        '.btn-bs-success': {
          '@apply text-center capitalize bg-green-500 text-white block py-2 px-5 rounded transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply opacity-75': {},
          },
        },
        '.btn-bs-danger': {
          '@apply text-center capitalize bg-red-500 text-white block py-2 px-5 rounded transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply opacity-75': {},
          },
        },
        '.btn-bs-info': {
          '@apply text-center capitalize bg-yellow-500 text-white block py-2 px-5 rounded transition-all ease-in-out duration-300': {},
          '&:hover': {
            '@apply opacity-75': {},
          },
        },
        '.menu-overflow': {
          '&:focus': {
            'outline': 'none',
          },
        },
      });
    }),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({ matchComponents, theme }) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = { name, fullPath: path.join(iconsDir, dir, file) }
        })
      })
      matchComponents({
        "hero": ({ name, fullPath }) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, { values })
    })
  ]
}
