package util

import (
	"testing"

	"github.com/google/uuid"
	"github.com/rubenhoenle/ci-cd-lecture-project-template/model"
	"github.com/stretchr/testify/assert"
)

func TestRemove(t *testing.T) {
	t.Run("remove user", func(t *testing.T) {
		users := []model.User{
			{Uuid: uuid.New(), DisplayName: "user1", Balance: 3.5},
			{Uuid: uuid.New(), DisplayName: "user2", Balance: 3.5},
			{Uuid: uuid.New(), DisplayName: "user3", Balance: 3.5},
		}

		updatedUsers := RemoveUser(users, 2)
		assert.Equal(t, 2, len(updatedUsers))
		assert.Equal(t, "user1", updatedUsers[0].DisplayName)
		assert.Equal(t, "user2", updatedUsers[1].DisplayName)
	})
}
