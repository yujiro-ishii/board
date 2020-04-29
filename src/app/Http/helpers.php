<?php

function resolveProfileImage($user) {
    if (preg_match('/^https?:\/\//', $user->profile_image)) {
        return $user->profile_image;
    } else {
        return asset('storage/profile_image/' . $user->profile_image);
    }
}
