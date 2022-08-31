const {exec, execSync} = require('child_process')

// Note: stdio: pipe is to prevent any output getting printed to console directly, yikes!!
const options = {stdio: 'pipe'}

// Note for some reason🥊︎ ``ls **.html`` isn't working, else it doens recursively getting html files directly.
let list = []

// console.log(process.cwd())
// console.log(__dirname)

// Note: 🥝︎ I am keeping every level of list in each try catch so that failing at top level won't stop the nested level scan for html files.

try {
  let list1 = execSync(`ls *.html`, options).toString()
  list1 = list1.split('\n').slice(0, -1) // Also remove the last item, i.e., empty string.
  list.push(...list1)
} catch (error) {
  // console.log('yikes error.... ~sahil')
}

try {
  let list2 = execSync(`ls **/*.html`, options).toString()
  list2 = list2.split('\n').slice(0, -1)
  list.push(...list2)
} catch (error) {
  // console.log('yikes error.... ~sahil')
}

try {
  let list3 = execSync(`ls **/**/*.html`, options).toString()
  list3 = list3.split('\n').slice(0, -1)
  list.push(...list3)
} catch (error) {
  // console.log('yikes error.... ~sahil')
}

try {
  let list4 = execSync(`ls **/**/**/*.html`, options).toString()
  list4 = list4.split('\n').slice(0, -1)
  list.push(...list4)
} catch (error) {
  // console.log('yikes error.... ~sahil')
}

try {
  let list5 = execSync(`ls **/**/**/**/*.html`, options).toString()
  list5 = list5.split('\n').slice(0, -1)
  list.push(...list5)
} catch (error) {
  // console.log('yikes error.... ~sahil')
}

try {
  let list6 = execSync(`ls **/**/**/**/**/*.html`, options).toString()
  list6 = list6.split('\n').slice(0, -1)
  list.push(...list6)
} catch (error) {
  // console.log('yikes error.... ~sahil')
}

try {
  let list7 = execSync(`ls **/**/**/**/**/**/*.html`, options).toString()
  list7 = list7.split('\n').slice(0, -1)
  list.push(...list7)
} catch (error) {
  // console.log('yikes error.... ~sahil')
}

try {
  let list8 = execSync(`ls **/**/**/**/**/**/**/*.html`, options).toString()
  list8 = list8.split('\n').slice(0, -1)
  list.push(...list8)
} catch (error) {
  // console.log('yikes error.... ~sahil')
}

list = list.filter((item) => !item.includes('dist/') && !item.includes('node_modules'))

module.exports = list

// console.log(list)
