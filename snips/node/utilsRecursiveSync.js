const fs = require('fs')
const path = require('path')

// const directoryPath = path.join(__dirname, 'Documents')
// const directoryPath = __dirname

const getFolders = (folderPath) => {
	const items = fs.readdirSync(folderPath)

	// if (err) {
	// 	return console.log('Unable to scan directory: ' + err)
	// }

	// src: checking if a item is a folder or not : https://stackoverflow.com/a/15630832/10012446
	return items.filter(
		(item) =>
			!fs.lstatSync(path.join(folderPath, item)).isFile() &&
			item !== 'dist' &&
			item !== '.cache' &&
			item !== 'node_modules'
	)
}

const getHtmlFiles = (directory) => {
	const items = fs.readdirSync(directory)
	let htmlFiles = items.filter((item) => item.includes('.html'))

	// items could be files + folders
	// console.log({filesFolders: items})
	// console.log({htmlFiles})
	return htmlFiles
}

const getNestedHtmlFilePaths = (folder_path) => {
	let filePaths = []

	const rootHtmlFiles = getHtmlFiles(folder_path)
	filePaths.push(...rootHtmlFiles)

	const folders = getFolders(folder_path)
	// 💨︎ This 🔽︎ works magically though, a series solution...
	folders.forEach((folder) => {
		let htmlFilePaths = getHtmlFiles(folder)

		const filesWithPath = joinFileFolderPaths(folder, htmlFilePaths)

		filePaths.push(...filesWithPath)
	})

	// console.log(filePaths) // debug...
	return filePaths
}

// const getHtmlFilesRecursive = (directory) => {
// 	// console.log('called recursive with:', directory) // !

// 	const items = fs.readdirSync(directory)

// 	// items could be files + folders
// 	// console.log({filesFolders: items})
// 	// 🔽︎🔽︎🔽︎🔽︎ watch the ? operator here..
// 	let htmlFiles = items ? items.filter((item) => item.includes('.html')) : []
// 	// console.log({htmlFiles})
// 	// console.log({directory})
// 	// console.log({directory_scoped})
// 	const folders = getFolders(directory)
// 	// console.log({folders})

// 	for (folder of folders) {
// 		// console.log({folder})

// 		let htmlFilePaths = getHtmlFilesRecursive(path.join(directory, folder)) // !
// 		// console.log({htmlFilePaths})

// 		const filesWithPath = joinFileFolderPaths(folder, htmlFilePaths)

// 		// console.log({filesWithPath})
// 		htmlFiles.push(...filesWithPath)
// 	}

// 	htmlFiles = joinFileFolderPaths(directory, htmlFiles)

// 	// console.log({htmlFiles})
// 	return htmlFiles
// }

function joinFileFolderPaths(folder, files) {
	return files.map((file) => {
		// file = path.basename(file)
		console.log({folder, file})
		return path.join(folder)
	})
}

module.exports = {
	getFolders,
	getHtmlFiles,
	getNestedHtmlFilePaths,
	getHtmlFilesRecursive,
}
// I used ``getFolders`` in ``getNestedHtmlFilePaths``

// ⚡︎⚡︎ Testing...
// console.log(getFolders('.'))
// console.log(getHtmlFiles('.'))
// console.log(getNestedHtmlFilePaths('.'))
// main testing...
// console.log(getHtmlFilesRecursive(__dirname))
// console.log(path.basename(__dirname))

main()
