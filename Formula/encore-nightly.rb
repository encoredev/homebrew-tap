class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230804"
    checksums = {
        "darwin_arm64" => "9a4097fff9a4cd0067cbbb797e9894dccb80d906d3441d4baef7e46b5cc78ac7",
        "darwin_amd64" => "6fce1eaa4517637dadea6311928e4514415ba3a72efdea1618b8d4b7d8fc9682",
        "linux_arm64"  => "62a3d42e22396b26c310cbf2498bc4ceb966270ebbc582a029c6c49351eb02c4",
        "linux_amd64"  => "c758700feed1108266bddc4ce2d4ab79cbb7e325583b6d17b822709484f5e719",
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
