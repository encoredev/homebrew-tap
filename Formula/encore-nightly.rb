class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230710"
    checksums = {
        "darwin_arm64" => "0641847d5da513f3d16e4f48f77dccc2c74b36257635b1ce69e7ab8edb0d45d2",
        "darwin_amd64" => "5a4a6c3d4245e3545f5ffe0b58f681c6331f5450f21b9f75cdd341f332832c54",
        "linux_arm64"  => "4e104f69b26a83ba21c4d7e850e7899629e483bfa09389a2ec186bed7bdd4875",
        "linux_amd64"  => "e13b05c72e46a90101272e5fc22ef20ab7ae8423a2bd08793f86256bf1f3bf4f",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
