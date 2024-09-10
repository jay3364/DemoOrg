import { api, LightningElement, track } from 'lwc';

export default class RecordEditForm extends LightningElement {
    nums = [1, 0, -1, 0, -2, 2]; // Example input array
    target = 0; // Example target
    quadruplets = [];

    connectedCallback() {
        this.quadruplets = this.findQuadruplets(this.nums, this.target);
        console.log('nums===>',this.nums, '  target==>',this.target);
        
    }

    displayInfo = {
        primaryField: 'Account.FirstName', 
    };
    

    findQuadruplets(nums, target) {
        nums.sort((a, b) => a - b);
        const result = [];
        console.log('numsss==>',JSON.stringify(nums));
        
        for (let i = 0; i < nums.length - 3; i++) {
            if (i > 0 && nums[i] === nums[i - 1]) continue; // Skip duplicates
            console.log('i==>',nums[i]);
            console.log('length==>',nums.length);
            
            for (let j = i + 1; j < nums.length - 2; j++) {
                console.log(nums[0]);
                console.log(nums[j]);
                
                
                if (j > i + 1 && nums[j] === nums[j - 1]) continue; // Skip duplicates
                    console.log('J==>',nums[j]);
                    console.log(j);
                    

                let left = j + 1;
                let right = nums.length - 1;
                    console.log('RIGHT=>',right,'  left==>',left);
                    
                while (left < right) {
                    const sum = nums[i] + nums[j] + nums[left] + nums[right];
                    console.log('sum==>',sum , 'num[i]',nums[i],' nums[j]',nums[j],' num[left]',nums[left],' num[right]',nums[right]);
                    
                    if (sum === target) {
                        result.push([nums[i], nums[j], nums[left], nums[right]]);
                        console.log('result==>',JSON.stringify(result));
                        
                        while (left < right && nums[left] === nums[left + 1]) left++; // Skip duplicates
                        while (left < right && nums[right] === nums[right - 1]) right--; // Skip duplicates
                        left++;
                        right--;
                    } else if (sum < target) {
                        left++;
                    } else {
                        right--;
                    }
                }
            }
        }

        return result;
    }

    makeBold() {
        // Get the selected text range
        const selection = window.getSelection();
        console.log('selction',selection);
        
        if (selection.rangeCount > 0) {
            // Get the range of the selected text
            const range = selection.getRangeAt(0);
                console.log('range=>',range);
                
            // Create a <b> element
            const boldElement = document.createElement('b');
                console.log('boldElement',boldElement);
                
            // Extract the selected text and place it inside the <b> element
            boldElement.appendChild(range.extractContents());
                console.log('boldElement',boldElement);
                
            // Insert the <b> element back into the document
            range.insertNode(boldElement);
            console.log('range==',range);
            
            // Clear the current selection
            selection.removeAllRanges();
        }
}
}