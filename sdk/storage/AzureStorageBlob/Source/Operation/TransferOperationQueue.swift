// --------------------------------------------------------------------------
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the ""Software""), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//
// --------------------------------------------------------------------------

import Foundation

internal class TransferOperationQueue: OperationQueue {
    // MARK: Internal Methods

    func add(_ operation: TransferOperation) {
        add([operation])
    }

    func add(_ operations: [TransferOperation]) {
        let states = operations.map { $0.transfer.state.rawValue }
        for state in Set(states) {
            let filteredOps = operations.filter { $0.transfer.state.rawValue == state }
            var transferState = TransferState(rawValue: state)!
            let allowed: [TransferState] = [.pending, .inProgress]
            if allowed.contains(transferState) {
                // reset inProgress back to pending since they may be scheduled differently
                transferState = .pending

                // For Pending or InProgress operations, need to requeue the operations
                for operation in filteredOps {
                    let operationClosure = operation.completionBlock
                    operation.completionBlock = {
                        operationClosure?()
                        if !operation.transfer.isActive {
                            return
                        }
                    }
                }
                addOperations(filteredOps, waitUntilFinished: false)
            }
        }
    }
}