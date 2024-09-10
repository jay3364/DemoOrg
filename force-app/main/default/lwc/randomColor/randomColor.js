import { LightningElement, track } from 'lwc';

export default class ColorGrid extends LightningElement {
    @track grid = [];
    @track intersectionGrid = [];
    colors = ['red', 'blue', 'green', 'yellow'];
    rowIntersection = [2, 3]; // Example row indices for intersections
    colIntersection = [2, 10]; // Example column indices for intersections

    connectedCallback() {
        this.generateGrids();
    }

    handleRefresh() {
        this.generateGrids();
    }

    generateGrids() {
        this.generateMainGrid();
        this.generateIntersectionGrid();
    }

    generateMainGrid() {
        let newGrid = [];

        for (let i = 0; i < 12; i++) {
            let row = { rowId: i, cells: [] };
            for (let j = 0; j < 12; j++) {
                let color = this.getRandomColor();
                row.cells.push({ cellId: `${i}-${j}`, style: `background-color: ${color}` });
            }
            newGrid.push(row);
        }

        this.grid = newGrid;
    }

    generateIntersectionGrid() {
        let newIntersectionGrid = [];
        
       
        let intersectionColors = [...this.colors];
        this.shuffleArray(intersectionColors);

        for (let i = 0; i < 12; i++) {
            let row = { rowId: this.rowIntersection[i], cells: [] };
            for (let j = 0; j < 12; j++) {
                let color = intersectionColors[i * this.colIntersection.length + j];
                row.cells.push({ cellId: `${this.rowIntersection[i]}-${this.colIntersection[j]}`, style: `background-color: ${color}` });
            }
            newIntersectionGrid.push(row);
        }

        this.intersectionGrid = newIntersectionGrid;
    }

    getRandomColor() {
        return this.colors[Math.floor(Math.random() * this.colors.length)];
    }

    shuffleArray(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
    }
}