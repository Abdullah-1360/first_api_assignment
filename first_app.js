const express = require('express');
const fs = require('fs');
const app = express();
 users= require('./MOCK_DATA.json');
app.use(express.urlencoded({
  extended: false
}));
app.get('/users', (req, res) => {
  return res.json(users);
});
app.get('/user/:id', (req, res) => {
  const id = Number(req.params.id);
  const user = users.find((u) => u.id === id);
  return res.json(user);
})
app.post('/user', (req, res) => {
    const body = req.body;
    users.push({ id: users.length + 1,...body});
    fs.writeFileSync('./MOCK_DATA.json', JSON.stringify(users));
    return res.json({
      status: 'success'});
})
app.delete('/user/:id', (req, res) => {
   id = Number(req.params.id);
  users = users.filter((u) => u.id !== id);
  fs.writeFileSync('./MOCK_DATA.json', JSON.stringify(users));
  return res.json({
    status: 'successful'});
})
const port =  3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
