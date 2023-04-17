module.exports = {
  chainWebpack: config => {
    config.module
      .rule('js')
      .exclude.add(/node_modules\/(?!vue-router\/|@vue\/.*\/)/)
  }
}