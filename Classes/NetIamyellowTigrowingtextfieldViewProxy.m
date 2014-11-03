//
//   Copyright 2012 jordi domenech <jordi@iamyellow.net>
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//

#import "NetIamyellowTigrowingtextfieldViewProxy.h"
#import "TiUtils.h"
#import "NetIamyellowTigrowingtextfieldView.h"

@implementation NetIamyellowTigrowingtextfieldViewProxy

-(id)value
{
    return [(NetIamyellowTigrowingtextfieldView*)[self view] text];
}

-(void)setValue:(id)value
{
    ENSURE_TYPE(value, NSString);
    [(NetIamyellowTigrowingtextfieldView*)[self view] setText:value];
}

-(void)focus:(id)args
{
    [(NetIamyellowTigrowingtextfieldView*)[self view] focus];
}

-(void)blur:(id)args
{
    [(NetIamyellowTigrowingtextfieldView*)[self view] blur];
}

@end
