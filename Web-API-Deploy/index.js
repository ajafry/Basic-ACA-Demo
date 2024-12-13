const express = require('express')

const app = express();

const port = process.env.PORT || 8080;

const server = app.listen(port, () => {
    console.log(`Express is running on port ${server.address().port}`);
});

app.get('/', (req, res) => {
    res.send("Hello from the root route");
});

app.get('/people', (req, res) => {
    res.status(200).send("Lots of people");
});

app.get('/people/:name', (req, res) => {
    res.status(200).send(`Hello from lots of people to ${req.params.name}`);
});