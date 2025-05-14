import {Router} from 'express'
import { promises as fs } from 'fs'
import path from 'path'

const rotas = Router();

rotas.get('/ping',pong)

function pong(req,res){
    res.send({"pong":"pong"})
}
export default rotas