/* Example function on how to trigger a bot action */

module.exports = (robot) => {

  robot.hear('dojo test', (res) => {
    return res.send('This is the Green Belt Dojo! :muscle:');
  });
  
}