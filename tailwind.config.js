module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: [
      {
        'light': {
            'primary' : '#19cc4f',
            'primary-focus' : '#17b547',
            'primary-content' : '#ffffff',

            'secondary' : '#ff7161',
            'secondary-focus' : '#dd6255',
            'secondary-content' : '#ffffff',

            'accent' : '#37bccd',
            'accent-focus' : '#2b98a6',
            'accent-content' : '#ffffff',

            'neutral' : '#072f74',
            'neutral-focus' : '#001a57',
            'neutral-content' : '#ffffff',

            'base-100' : '#fbfffa',
            'base-200' : '#f1ffe0',
            'base-300' : '#dfffd1',
            'base-content' : '#40006b',

            'info' : '#9eb1ff',
            'success' : '#00d1bc',
            'warning' : '#ebd700',
            'error' : '#ff825c',

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