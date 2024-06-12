module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
        animation: {
            "heartbeat": "heartbeat 2.0s ease  infinite both",
            "bounce-in-top": "bounce-in-top 1.1s ease   both",
            "roll-in-left": "roll-in-left 1.3s ease   both",
            "fade-in-bottom": "fade-in-bottom 1.2s cubic-bezier(0.390, 0.575, 0.565, 1.000)   both",
            "fade-in": "fade-in 2.0s cubic-bezier(0.390, 0.575, 0.565, 1.000)   both",
            "slide-in-bck-right": "slide-in-bck-right 1.2s cubic-bezier(0.250, 0.460, 0.450, 0.940)   both",
            "slide-in-bck-left": "slide-in-bck-left 1.2s cubic-bezier(0.250, 0.460, 0.450, 0.940)   both",
            "tracking-in-expand": "tracking-in-expand 1.4s cubic-bezier(0.215, 0.610, 0.355, 1.000)   both",
            "tracking-in-contract": "tracking-in-contract 0.7s cubic-bezier(0.215, 0.610, 0.355, 1.000)   both",
            "roll-in-bottom": "roll-in-bottom 0.6s ease   both",
            "swirl-in-fwd": "swirl-in-fwd 0.6s ease   both",
            "roll-out-right": "roll-out-right 12.0s ease   both",
            "rotate-out-center": "rotate-out-center 0.5s cubic-bezier(0.550, 0.085, 0.680, 0.530)   both",
            "scale-in-hor-center": "scale-in-hor-center 0.5s cubic-bezier(0.250, 0.460, 0.450, 0.940)   both",
            "fade-out-top": "fade-out-top 0.7s cubic-bezier(0.250, 0.460, 0.450, 0.940)   both",
            'slide-in-bck-left-out': 'slide-in-bck-left 1s ease-in-out 0s 1 normal forwards, fade-out-top 1s ease-in-out 5s 1 normal forwards',
            "fade-in-bck": "fade-in-bck 0.7s cubic-bezier(0.390, 0.575, 0.565, 1.000)   both",
            "typing": "typing 2s steps(20)  alternate, blink .7s ",
            "rotate-center": "rotate-center 1.0s cubic-bezier(0.860, 0.000, 0.070, 1.000)  infinite  both"
        },
        keyframes: {
            "heartbeat": {
                "0%": {
                    transform: "scale(1)",
                    "transform-origin": "center center",
                    "animation-timing-function": "ease-out"
                },
                "10%": {
                    transform: "scale(.91)",
                    "animation-timing-function": "ease-in"
                },
                "17%": {
                    transform: "scale(.98)",
                    "animation-timing-function": "ease-out"
                },
                "33%": {
                    transform: "scale(.87)",
                    "animation-timing-function": "ease-in"
                },
                "45%": {
                    transform: "scale(1)",
                    "animation-timing-function": "ease-out"
                }
            },
            "bounce-in-top": {
              "0%": {
                  transform: "translateY(-500px)",
                  "animation-timing-function": "ease-in",
                  opacity: "0"
              },
              "38%": {
                  transform: "translateY(0)",
                  "animation-timing-function": "ease-out",
                  opacity: "1"
              },
              "55%": {
                  transform: "translateY(-65px)",
                  "animation-timing-function": "ease-in"
              },
              "72%,90%,to": {
                  transform: "translateY(0)",
                  "animation-timing-function": "ease-out"
              },
              "81%": {
                  transform: "translateY(-28px)"
              },
              "95%": {
                  transform: "translateY(-8px)",
                  "animation-timing-function": "ease-in"
              }
          },
          "roll-in-left": {
            "0%": {
                transform: "translateX(-800px) rotate(-540deg)",
                opacity: "0"
            },
            to: {
                transform: "translateX(0) rotate(0deg)",
                opacity: "1"
            }
          },
          "fade-in-bottom": {
            "0%": {
                transform: "translateY(50px)",
                opacity: "0"
            },
            to: {
                transform: "translateY(0)",
                opacity: "1"
            }
          },
          "fade-in": {
            "0%": {
                opacity: "0"
            },
            to: {
                opacity: "1"
            }
          },
          "slide-in-bck-right": {
            "0%": {
                transform: "translateZ(700px) translateX(400px)",
                opacity: "0"
            },
            to: {
                transform: "translateZ(0) translateX(0)",
                opacity: "1"
            }
          },
          "slide-in-bck-left": {
            "0%": {
                transform: "translateZ(700px) translateX(-400px)",
                opacity: "0"
            },
            to: {
                transform: "translateZ(0) translateX(0)",
                opacity: "1"
            }
          },
          "tracking-in-expand": {
            "0%": {
                "letter-spacing": "-.5em",
                opacity: "0"
            },
            "40%": {
                opacity: ".6"
            },
            to: {
                opacity: "1"
            }
          },
          "tracking-in-contract": {
            "0%": {
                "letter-spacing": "1em",
                opacity: "0"
            },
            "40%": {
                opacity: ".6"
            },
            to: {
                "letter-spacing": "normal",
                opacity: "1"
            }
          },
          "roll-in-bottom": {
            "0%": {
                transform: "translateY(800px) rotate(540deg)",
                opacity: "0"
            },
            to: {
                transform: "translateY(0) rotate(0deg)",
                opacity: "1"
            }
          },
          "swirl-in-fwd": {
            "0%": {
                transform: "rotate(-540deg) scale(0)",
                opacity: "0"
            },
            to: {
                transform: "rotate(0) scale(1)",
                opacity: "1"
            }
          },
          "roll-out-right": {
            "0%": {
                transform: "translateX(0) rotate(0deg)",
                opacity: "1"
            },
            to: {
                transform: "translateX(1000px) rotate(540deg)",
                opacity: "0"
            }
          },
          "rotate-out-center": {
            "0%": {
                transform: "rotate(0)",
                opacity: "1"
            },
            to: {
                transform: "rotate(-360deg)",
                opacity: "0"
            }
          },
          "scale-in-hor-center": {
            "0%": {
                transform: "scaleX(0)",
                opacity: "1"
            },
            to: {
                transform: "scaleX(1)",
                opacity: "1"
            }
          },
          "fade-out-top": {
            "0%": {
                transform: "translateY(0)",
                opacity: "1"
            },
            to: {
                transform: "translateY(-50px)",
                opacity: "0"
            }
          },
          "fade-in-bck": {
            "0%": {
                transform: "translateZ(80px)",
                opacity: "0"
            },
            to: {
                transform: "translateZ(0)",
                opacity: "1"
            }
          },
          "typing": {
            "0%": {
              width: "0%",
              visibility: "hidden"
            },
            "100%": {
              width: "100%"
            }
          },
          "blink": {
            "50%": {
              borderColor: "transparent"
            },
            "100%": {
              borderColor: "white"
            }
          },
          "rotate-center": {
            "0%": {
                transform: "rotate(0)"
            },
            to: {
                transform: "rotate(360deg)"
            }
          }
        }
    }
  },
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: [
      {
        'light': {
           'primary' : '#570df8',
           'primary-focus' : '#4506cb',
           'primary-content' : '#ffffff',

           'secondary' : '#f000b8',
           'secondary-focus' : '#bd0091',
           'secondary-content' : '#ffffff',

           'accent' : '#37cdbe',
           'accent-focus' : '#2ba69a',
           'accent-content' : '#ffffff',

           'neutral' : '#3b424e',
           'neutral-focus' : '#2a2e37',
           'neutral-content' : '#ffffff',

           'base-100' : '#ffffff',
           'base-200' : '#f9fafb',
           'base-300' : '#ced3d9',
           'base-content' : '#1e2734',

           'info' : '#ddb3ff',
           'success' : '#c0b8ff',
           'warning' : '#ffc266',
           'error' : '#ff61a0',

          '--rounded-box': '1rem',          
          '--rounded-btn': '.5rem',        
          '--rounded-badge': '1.9rem',      

          '--animation-btn': '.25s',       
          '--animation-input': '.2s',       

          '--btn-text-case': 'uppercase',   
          '--navbar-padding': '.5rem',      
          '--border-btn': '1px',            
        },
      },
    ],
  },
}

