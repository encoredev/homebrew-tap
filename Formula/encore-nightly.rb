class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230503"
    checksums = {
        "darwin_arm64" => "a8650264bbd839b1b40bc3fe073fd26a70d58977563050caa38e118ffd1c74f8",
        "darwin_amd64" => "1606440172f83ab9ffbc0ba1ad6651613ea08e590b4c3047e511032211766c08",
        "linux_arm64"  => "be44e2644c91e04913cfe1414f1a8314f937992b75563aa494c582a705ccd423",
        "linux_amd64"  => "a299d9f5edbb01112ce4ae19b4fc9585b9d6295a601753a091906ec0706c093c",
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
