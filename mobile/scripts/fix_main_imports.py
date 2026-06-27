
import os

filepath = 'lib/main.dart'

replacements = {
    'package:reservatior/features/notification/': 'package:reservatior/features/notifications/',
    'package:reservatior/features/message/': 'package:reservatior/features/messages/',
    'package:reservatior/features/favorite/': 'package:reservatior/features/favorites/',
    'package:reservatior/features/deal/': 'package:reservatior/features/deals/',
    'package:reservatior/features/task/': 'package:reservatior/features/tasks/',
    'package:reservatior/features/booking/': 'package:reservatior/features/bookings/',
    'package:reservatior/features/location/': 'package:reservatior/features/locations/',
    'package:reservatior/features/communication_log/': 'package:reservatior/features/communication_logs/',
    'package:reservatior/features/achievement/': 'package:reservatior/features/achievement/', # already singular in ls
}

with open(filepath, 'r') as f:
    content = f.read()

new_content = content
for old, new in replacements.items():
    new_content = new_content.replace(old, new)

if content != new_content:
    with open(filepath, 'w') as f:
        f.write(new_content)
    print(f'Fixed imports in {filepath}')
