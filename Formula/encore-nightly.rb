class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230609"
    checksums = {
        "darwin_arm64" => "74d28767956d7aecafeab0aec75a37c482417353325304a5efe77290bef470fd",
        "darwin_amd64" => "02d66c76b3ebbe26571177b56ccd9a4164d8dc89fa9fd2e51b45da8d370c99b9",
        "linux_arm64"  => "cd9b4a955b280f6746093d847bdfc10768ca1ce145beff28fae6bb995c613c05",
        "linux_amd64"  => "841eb706b011a694ff68c22b162940fbc45fd5de0b394a9f90b1a60c762a9409",
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
