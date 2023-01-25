class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230125"
    checksums = {
        "darwin_arm64" => "e59d3260fc600d49d3416b6827b14c2cc2bf296c1983ef88e5a76d7bb742e562",
        "darwin_amd64" => "f8831ba6b11cdf96c487b673f29bb4eceba4fd93d71a6d943e7f3c583168967c",
        "linux_arm64"  => "d004dc2859d8ca115919030f1a37b62b60126faf5606d1fe64a891e6d7e46c33",
        "linux_amd64"  => "f8bfa4bda70af94a8a7451d0231f1356165531cb55eae764a14993eaebb85d6e",
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
