import express from 'express'
import rotas from './app/routes/router.js'


const app = express()
const port = 3000

app.use(rotas)

app.listen(port, () => {
  console.log(`App de exemplo esta rodando na porta ${port}`)
})

