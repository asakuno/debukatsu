const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')

module.exports = environment
function hotfixPostcssLoaderConfig (subloader) {
  const subloaderName = subloader.loader
  if (subloaderName === 'postcss-loader') {
    if (subloader.options.postcssOptions) {
      console.log(
        '\x1b[31m%s\x1b[0m',
        'Remove postcssOptions workaround in config/webpack/environment.js'
      )
    } else {
      subloader.options.postcssOptions = subloader.options.config;
      delete subloader.options.config;
    }
  }
}

environment.loaders.keys().forEach(loaderName => {
  const loader = environment.loaders.get(loaderName);
  loader.use.forEach(hotfixPostcssLoaderConfig);
});

const webpack = require('webpack')
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery'
    })
)

 environment.plugins.prepend(
     'VueLoaderPlugin',
     new VueLoaderPlugin()
)

environment.loaders.prepend('vue', {
    test: /\.vue$/,
    use: [{
        loader: 'vue-loader'
    }]
})

const { DefinePlugin } = require('webpack')
environment.plugins.prepend(
    'Define',
    new DefinePlugin({
        __VUE_OPTIONS_API__: true,
        __VUE_PROD_DEVTOOLS__: true
    })
)

module.exports = environment