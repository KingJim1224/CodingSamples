"""empty message

Revision ID: d34d0b33f4b4
Revises: 
Create Date: 2023-08-28 22:00:27.397886

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'd34d0b33f4b4'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_index(op.f('ix_collect_addtime'), 'collect', ['addtime'], unique=False)
    op.drop_index('ix_cart_addtime', table_name='collect')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_index('ix_cart_addtime', 'collect', ['addtime'], unique=False)
    op.drop_index(op.f('ix_collect_addtime'), table_name='collect')
    # ### end Alembic commands ###
