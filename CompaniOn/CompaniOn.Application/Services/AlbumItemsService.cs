using AutoMapper;
using FluentValidation;
using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application
{
    public class AlbumItemsService : BaseService<AlbumItem, AlbumItemDto, AlbumItemUpsertDto, AlbumItemSearchObject, IAlbumItemsRepository>, IAlbumItemsService
    {
        private readonly IPhotosRepository _photosRepository;

        public AlbumItemsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<AlbumItemUpsertDto> validator, IPhotosRepository photosRepository) : base(mapper, unitOfWork, validator)
        {
            _photosRepository = photosRepository;
        }

        public override async Task<AlbumItemDto> AddAsync(AlbumItemUpsertDto dto, CancellationToken cancellationToken = default)
        {
            if (dto.Photo == null)
            {
                throw new Exception("You must add photo");
            }

            await ValidateAsync(dto, cancellationToken);

            var entity = Mapper.Map<AlbumItem>(dto);

            var albumItemPhoto = new Photo() { Data = dto.Photo , CreatedAt = DateTime.Now};
            await _photosRepository.AddAsync(albumItemPhoto, cancellationToken);
            await UnitOfWork.SaveChangesAsync();
            entity.PhotoId = albumItemPhoto.Id;

            await CurrentRepository.AddAsync(entity, cancellationToken);
            await UnitOfWork.SaveChangesAsync();

            return Mapper.Map<AlbumItemDto>(entity);
        }

        public override async Task<AlbumItemDto> UpdateAsync(AlbumItemUpsertDto dto, CancellationToken cancellationToken = default)
        {
            await ValidateAsync(dto, cancellationToken);

            if (dto.Id == null)
                throw new Exception("Album item not found");

            var albumItem = await CurrentRepository.GetByIdAsync(dto.Id.Value, cancellationToken);

            if (albumItem == null)
                throw new Exception("Album item not found");

            Mapper.Map(dto, albumItem);

            if (dto.Photo != null)
            {
                var photo = new Photo() { Id = albumItem.PhotoId, Data = dto.Photo, ModifiedAt = DateTime.Now };
                _photosRepository.Update(photo);
                UnitOfWork.SaveChanges();
            }

            CurrentRepository.Update(albumItem);
            await UnitOfWork.SaveChangesAsync();

            return Mapper.Map<AlbumItemDto>(albumItem);
        }

    }
}
