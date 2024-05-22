class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.37.5"
    checksums = {
        "darwin_arm64" => "eaf8edbc778d9fed4a1b157e5635f513a6abc0422c00ee06aa90fbfb0426758e",
        "darwin_amd64" => "fc4358ab4c25930e66d9484c48ab808f90c3c47b6a8469e4ae832fb6d022ecba",
        "linux_arm64"  => "2c3b1e50665ff89e0f18d7629cbdf5a1f2b5b8e941a8b03007f85738ccb21732",
        "linux_amd64"  => "0c1aeb51277582bea9ea0038d91590452c31b52fb5cf354e063b8649bd6595c2",
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
