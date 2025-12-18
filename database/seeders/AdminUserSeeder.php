<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Role;
use Illuminate\Support\Facades\Hash;

class AdminUserSeeder extends Seeder
{
    public function run(): void
    {
        // Define demo users for each role
        $demoUsers = [
            [
                'name' => 'Administrator',
                'email' => 'admin@mail.com',
                'password' => Hash::make('password'),
                'phone' => '+8801707080401',
                'gender' => 'male',
                'city' => 'Dhaka',
                'state' => 'Dhaka',
                'country' => 'Bangladesh',
                'bio' => 'System Administrator with full access to all features and settings.',
                'role_slug' => 'administrator',
            ],
            [
                'name' => 'Cashier',
                'email' => 'cashier@mail.com',
                'password' => Hash::make('password'),
                'phone' => '+8801707080402',
                'gender' => 'female',
                'city' => 'Dhaka',
                'state' => 'Dhaka',
                'country' => 'Bangladesh',
                'bio' => 'Cashier role for POS and due collection.',
                'role_slug' => 'cashier',
            ],
            [
                'name' => 'Storekeeper',
                'email' => 'store@mail.com',
                'password' => Hash::make('password'),
                'phone' => '+8801707080403',
                'gender' => 'male',
                'city' => 'Dhaka',
                'state' => 'Dhaka',
                'country' => 'Bangladesh',
                'bio' => 'Storekeeper to manage purchases, products, and stock.',
                'role_slug' => 'storekeeper',
            ],
        ];

        // Create or update users and assign roles
        foreach ($demoUsers as $userData) {
            $roleSlug = $userData['role_slug'];
            unset($userData['role_slug']);

            // Create or update user
            $user = User::updateOrCreate(
                ['email' => $userData['email']],
                $userData
            );

            // Assign role to the user
            $role = Role::where('slug', $roleSlug)->first();
            if ($role && !$user->roles()->where('roles.id', $role->id)->exists()) {
                $user->roles()->attach($role->id);
            }
        }

        $this->command->info('Demo users created successfully for all roles!');
    }
}
