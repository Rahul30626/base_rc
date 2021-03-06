const express = require('express')
const bodyParser = require('body-parser')
const mysql = require('mysql')

const app = express()
const port = process.env.PORT || 5000;


app.use(bodyParser.urlencoded({ extended: false }))


app.use(bodyParser.json())

// MySQL
const pool  = mysql.createPool({
    connectionLimit : 10,
    host            : 'localhost',
    user            : 'root',
    password        : 'password',
    database        : 'nodejs_repairstation'
})
   
app.get('', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log('connected as id ' + connection.threadId)
        connection.query('SELECT * from repairstation', (err, rows) => {
            connection.release() 

            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }

            console.log('The data from repairstation table are: \n', rows)
        })
    })
})

app.get('/:id', (req, res) => {
    pool.getConnection((err, connection) => {
        if(err) throw err
        connection.query('SELECT * FROM repairstation WHERE id = ?', [req.params.id], (err, rows) => {
            connection.release() 
            if (!err) {
                res.send(rows)
            } else {
                console.log(err)
            }
            
            console.log('The data from repairstation table are: \n', rows)
        })
    })
});

app.delete('/:id', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        connection.query('DELETE FROM repairstation WHERE id = ?', [req.params.id], (err, rows) => {
            connection.release() 
            if (!err) {
                res.send(`repairstation with the record ID ${[req.params.id]} has been removed.`)
            } else {
                console.log(err)
            }
            
            console.log('The data from repairstation table are: \n', rows)
        })
    })
});

app.post('', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        
        const params = req.body
        connection.query('INSERT INTO repairstation SET ?', params, (err, rows) => {
        connection.release() 
        if (!err) {
            res.send(`repairstation with the record ID  has been added.`)
        } else {
            console.log(err)
        }
        
        console.log('The data from repairstation table are:11 \n', rows)

        })
    })
});


app.put('', (req, res) => {

    pool.getConnection((err, connection) => {
        if(err) throw err
        console.log(`connected as id ${connection.threadId}`)

        const { id, name, tagline, description, image } = req.body

        connection.query('UPDATE repairstation SET name = ?, tagline = ?, description = ?, image = ? WHERE id = ?', [name, tagline, description, image, id] , (err, rows) => {
            connection.release() 

            if(!err) {
                res.send(`repairstation with the name: ${name} has been added.`)
            } else {
                console.log(err)
            }

        })

        console.log(req.body)
    })
})



app.listen(port, () => console.log(`Listening on port ${port}`))