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
